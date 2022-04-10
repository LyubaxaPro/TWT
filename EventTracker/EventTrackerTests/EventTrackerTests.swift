//
//  EventTrackerTests.swift
//  EventTrackerTests
//
//  Created by Liubov Prokhorova on 19.03.2022.
//

import XCTest
@testable import EventTracker

class EventTrackerTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testCitiesFilterUpdate() throws {
        let filterPresenter = FilterPresenter(router: FilterRouterInputMock(), interactor: FilterInteractorInputMock())
        let citiesFilterPresenter = CitiesFilterPresenter(
            router: CitiesFilterRouterInputMock(),
            interactor: CitiesFilterInteractorInputMock(),
            previousCity: "msk"
        )
        citiesFilterPresenter.moduleOutput = filterPresenter
        citiesFilterPresenter.didChangeCity(city: "spb")
        
        XCTAssertEqual(citiesFilterPresenter.chosenCity, "spb")
        XCTAssertEqual(filterPresenter.filterInfo.city.cityName, "spb")
    }
    
    func testCitiesFilterSameCity() throws {
        let filterPresenter = FilterPresenter(router: FilterRouterInputMock(), interactor: FilterInteractorInputMock())
        let citiesFilterPresenter = CitiesFilterPresenter(
            router: CitiesFilterRouterInputMock(),
            interactor: CitiesFilterInteractorInputMock(),
            previousCity: "msk"
        )
        citiesFilterPresenter.moduleOutput = filterPresenter
        citiesFilterPresenter.didChangeCity(city: "msk")
        
        XCTAssertEqual(citiesFilterPresenter.chosenCity, "msk")
        XCTAssertEqual(filterPresenter.filterInfo.city.cityName, "msk")
    }
    
    func testCategoriesFilterChoosen() throws {
        let filterPresenter = FilterPresenter(router: FilterRouterInputMock(), interactor: FilterInteractorInputMock())
        let categoriesFilterPresenter = CategoriesFilterPresenter(
            router: CategoriesFilterRouterInputMock(),
            interactor: CategoriesFilterInteractorInputMock(),
            previousCategories: [String : Bool]()
        )
        categoriesFilterPresenter.moduleOutput = filterPresenter
        categoriesFilterPresenter.didСhooseCheckmark(with: "test_category")
        
        XCTAssertEqual(categoriesFilterPresenter.chosenCategories["test_category"], true)
        XCTAssertEqual(filterInfo.categories["test_category"], true)
    }
    
    func testCategoriesFilterCancel() throws {
        let filterPresenter = FilterPresenter(router: FilterRouterInputMock(), interactor: FilterInteractorInputMock())
        let categoriesFilterPresenter = CategoriesFilterPresenter(
            router: CategoriesFilterRouterInputMock(),
            interactor: CategoriesFilterInteractorInputMock(),
            previousCategories: ["test_category": true]
        )
        categoriesFilterPresenter.moduleOutput = filterPresenter
        categoriesFilterPresenter.didСanceledCheckmark(with: "test_category")
        
        XCTAssertEqual(categoriesFilterPresenter.chosenCategories["test_category"], false)
        XCTAssertEqual(filterInfo.categories["test_category"], false)
    }
    
    func testPosterServiceLoaderURL() throws {
        let posterServiceInfoMock = PosterServiceInfo(location: "msk", category: ["entertainment"])
        let resultURLString = "https://kudago.com/public-api/v1.3/events/?location=msk&categories=entertainment&page_size=500&actual_since=1649609319.368928&fields=id,title,short_title,place,description,categories,age_restriction,price,is_free,images,site_url&expand=place"
        let posterServiceLoader = PosterServiceLoader(posters: posterServiceInfoMock)
        XCTAssertEqual(posterServiceLoader.posterUrl(), resultURLString)
    }
}
