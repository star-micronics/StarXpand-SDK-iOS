- [日本語](docs/CHANGELOG_JP.md)

# Change Log

## 2.0.0 (2022/04/07)

* Confirmed that the issue has been resolved in Xcode13.3, which is unable to run applications built with Xcode13.2/13.2.1 on iOS 12 devices. #1

* Change
    - Methods that use async in StarPrinter class are now available in iOS 13 and later.
* Breaking change
    - Methods that take completion as an argument in StarPrinter class are now supported only in iOS 12.
        - For detailed information and migration procedures, please refer to the "[Migration Procedures from v1.0.0](https://star-m.jp/products/s_print/sdk/starxpand/manual/en/ios-swift/migration/index.html)" page.
      
## 1.0.0 (2022/01/31)

* First release
