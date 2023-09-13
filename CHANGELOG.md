- [日本語](docs/CHANGELOG_JP.md)

# Change Log

## 2.4.0 (2023/09/08)

* Added TSP100IV SK support.
* Changed minimum supported OS version from 12 to 13.
  * The methods for iOS 12 in the StarPrinter class are deprecated. The following methods are provided only for compatibility of applications supporting iOS 12 and will be removed in the future when the minimum supported OS version of this SDK is raised to iOS 15.
    - open(completion: @escaping (Error?) -> Void) 　　
    - print(command: String, completion: @escaping (Error?) -> Void) 　　
    - print(command: String, starSpoolJobSettings: StarSpoolJobSettings, completion: @escaping (Int?, Error?) -> Void) 　　
    - print(raw: Data, completion: @escaping (Error?) -> Void) 　　
    - getStatus(completion: @escaping (StarIO10.StarPrinterStatus?, Error?) -> Void) 　　
    - getSpoolJobStatus(jobId: Int, completion: @escaping (StarSpoolJobStatus?, Error?) -> Void) 　　
    - getSpoolJobStatusList(size: Int, completion: @escaping ([StarSpoolJobStatus]?, Error?) -> Void) 　　
    - getStarConfiguration(completion: @escaping (String?, Error?) -> Void) 　　
    - getDefaultStarConfiguration(completion: @escaping (String?, Error?) -> Void) 　　
    - setStarConfiguration(starConfiguration: String, completion: @escaping (Error?) -> Void) 　　
    - close(completion: @escaping () -> Void)

## 2.3.0 (2023/03/31)

* Added mC-Label3 support.
* Added API for spooler function.
* Added API for Page Mode.
* Added API for setting/getting Star Configuration.
* Added API for getting detailed status.
* Added printing samples of the spooler function and several samples of printing patterns for labels to the example app.
* Supported for Xcode 14.
  * Changed to not include Bitcode based on Apple policy.

* Bug Fix:
  * Fixed an issue that command generation does not execute when adding a Builder immediately after instantiation.

## 2.2.0 (2022/05/10)

* Added POP10CI support.

## 2.0.0 (2022/04/07)

* Confirmed that the issue has been resolved in Xcode13.3, which is unable to run applications built with Xcode13.2/13.2.1 on iOS 12 devices. #1

* Change
    - Methods that use async in StarPrinter class are now available in iOS 13 and later.
* Breaking change
    - Methods that take completion as an argument in StarPrinter class are now supported only in iOS 12.
        - For detailed information and migration procedures, please refer to the "[Migration Procedures from v1.0.0](https://star-m.jp/products/s_print/sdk/starxpand/manual/en/ios-swift/migration/index.html)" page.
      
## 1.0.0 (2022/01/31)

* First release
