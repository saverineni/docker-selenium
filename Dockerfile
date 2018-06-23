FROM openjdk:8

# We need wget to set up the PPA, Xvfb to have a virtual screen and unzip to extract ChromeDriver
RUN apt-get update
RUN apt-get install maven -y --allow-unauthenticated
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ARG chrome_driver_version=2.38
ARG CHROMEDRIVER_DIR=/chromedriver
RUN echo "chrome driver version $chrome_driver_version"

# Download and install ChromeDriver
RUN mkdir $CHROMEDRIVER_DIR
RUN wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$chrome_driver_version/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR

ADD pom.xml /docker-selenium/
ADD src /docker-selenium/src
ADD test /docker-selenium/test
WORKDIR /docker-selenium/

RUN mvn test