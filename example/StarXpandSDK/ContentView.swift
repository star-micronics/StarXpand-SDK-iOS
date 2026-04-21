import SwiftUI

struct ContentView: View {
    @State private var isProcessing = false {
        didSet {
            UIApplication.shared.isIdleTimerDisabled = isProcessing
        }
    }

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    NavigationLink(destination: DiscoveryView(isProcessing: $isProcessing)) {
                        Text("Discovery")
                    }
                    .disabled(isProcessing)
                    .padding()

                    NavigationLink(destination: PrintingView(isProcessing: $isProcessing)) {
                        Text("Printing")
                    }
                    .disabled(isProcessing)
                    .padding()

                    NavigationLink(destination: SpoolerView(isProcessing: $isProcessing)) {
                        Text("Printing -Spooler-")
                    }
                    .disabled(isProcessing)
                    .padding()

                    NavigationLink(destination: TemplatePrintView(isProcessing: $isProcessing)) {
                        Text("Printing -Template-")
                    }
                    .disabled(isProcessing)
                    .padding()

                    NavigationLink(destination: MonitorView(isProcessing: $isProcessing)) {
                        Text("Monitor")
                    }
                    .disabled(isProcessing)
                    .padding()

                    NavigationLink(destination: StatusView(isProcessing: $isProcessing)) {
                        Text("Status")
                    }
                    .disabled(isProcessing)
                    .padding()
                    
                    NavigationLink(destination: FirmwareUpdateView(isProcessing: $isProcessing)) {
                        Text("FirmwareUpdate")
                    }
                    .disabled(isProcessing)
                    .padding()
                }
                .navigationTitle("StarXpand")
            }.navigationViewStyle(StackNavigationViewStyle())
            
            if isProcessing {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {}

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: 48, height: 48)
            }
        }
    }
}

struct Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @State private var isProcessing = false
        var body: some View {
//            DiscoveryView(isProcessing: $isProcessing)
            PrintingView(isProcessing: $isProcessing)
//            SpoolerView(isProcessing: $isProcessing)
//            TemplatePrintView(isProcessing: $isProcessing)
//            MonitorView(isProcessing: $isProcessing)
//            StatusView(isProcessing: $isProcessing)
//            FirmwareUpdateView(isProcessing: $isProcessing)
        }
    }
}
