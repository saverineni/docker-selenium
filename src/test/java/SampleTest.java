import org.junit.Assert;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.DesiredCapabilities;

public class SampleTest {

    @Test
    public void sampleTest() {
        //String chromepath = "/chromedriver/chromedriver";
        String chromepath = "/docker-selenium/test/drivers/linux/chrome/chromedriver";
        System.setProperty("webdriver.chrome.driver", chromepath);

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless");
        options.addArguments("--no-sandbox");

        ChromeDriver driver = new ChromeDriver(options);

        String baseUrl = "http://www.facebook.com";
        String tagName = "";

        driver.get(baseUrl);
        tagName = driver.findElement(By.id("email")).getTagName();
        Assert.assertEquals("input", tagName);
        driver.close();
    }

}
