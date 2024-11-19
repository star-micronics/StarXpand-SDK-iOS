- [日本語](docs/CHANGELOG_JP.md)

# Change Log

## 2.8.0 (2024/10/18)

* Added TSP100IV-UEWB and TSP100IV-UEWB SK support.
* Added API to get detail information of printer.
  * detail property of StarPrinterInformation
  * StarPrinterInformationDetail
  * StarPrinterInformationLan
  * StarPrinterInformationBluetooth
  * StarPrinterInformationBluetoothLE
  * StarPrinterInformationUSB
* Added API to get detail information of error.
  * errorDetail property of StarPrinter
  * StarIO10ErrorDetail
* Preparing for update to Swift6. (modified the sample app so that it can be built with Swift6)
* Bug Fix:
  * Fixed an issue where StarIO10 failed to open and discover printer via LAN with the Xcode16 and iOS 18. [#31](https://github.com/star-micronics/StarXpand-SDK-iOS/issues/31)

## 2.7.0 (2024/06/24)

* Added BSC10II support (Limited region model).
* Added tearOff (feed to tear bar) to the CutType enum.
* Added india to the Printer.InternationalCharacterType enum.
* Changed so that StarIO10Error.inUse is thrown immediately when StarPrinter.open() is executed for a LAN printer that has already been opened by another device if autoSwitchInterface is false.
* Bug Fix:
  * Fixed an issue where occasionally caused a crash when executing print operations on multiple printers at the same time.
  * Fixed an issue where StarIO10Error.illegalDeviceState(message: "Network Unavailable.") could occasionally be thrown even though the iOS device is actually connected to the network.

## 2.6.1 (2024/03/27)

* Bug Fix
  * Fixed privacy manifest file according to Apple's App Review. (StarIO10 does not use Required Reason API.)

## 2.6.0 (2024/02/09)

* Added POP10CBI support.
* Added API for template printing function.
* Added a screen for template printing to the sample app.
* Added API for specifying number of character function.
* Added API for setting full/half-width of Unicode ambiguous characters.
* Changed the Auto Switch Interface function to enabled by default.
* Improved switching speed of the Auto Switch Interface function.
* Added several samples of printing patterns using template printing function.
* Added privacy manifest file according to Apple's guidelines. (StarIO10 does not use Required Reason API.)

## 2.5.0 (2023/10/27)

* Added MCP31CI/CBI support.
* Added a sample to generate receipt images from text data.

* Bug Fix:
  * Fixed to be able to print to printers on different segment networks by specifying IP address. [#14](https://github.com/star-micronics/StarXpand-SDK-iOS/issues/14)
  * Fixed an issue where decorations (methods starting with `style`) set with `DocumentBuilder.addPrinter()` were not reset when the method ended.

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
