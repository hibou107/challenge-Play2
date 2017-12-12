package services

import org.scalatest.{FlatSpec, Matchers}

class RealDataTests extends FlatSpec with Matchers {
  "Real data test" should "work correctly" in {
    val data = CSVLoader.loadData("airports.csv", "runways.csv", "countries.csv").get
    val report = data.reports(10)
    report.highest.size shouldBe 10
    report.lowest.size shouldBe 10
    data.searchCountry("test") shouldBe Nil
    data.searchCountry("us").size shouldBe 1
    data.searchCountry("").size shouldBe 0

  }
}
