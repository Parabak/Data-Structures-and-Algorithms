import Foundation

struct Request {
    let timestamp: Int
    let ip: String
}


// Prerequisite: requests are already sorted by time
func ignoringRequests(_ requests: [Request], limitPerSecond: Int) -> [Request] {

    var filteredRequests = [Request]()
    var ipRequests = [String: [Int]]()

    for request in requests {

        var existingTimestamps = ipRequests[request.ip, default: []]
        if existingTimestamps.count > 0 {

            existingTimestamps = existingTimestamps.filter {
                $0 >= request.timestamp - request.timestamp % 1000
            }
        }

        if existingTimestamps.count < limitPerSecond {
            existingTimestamps.append(request.timestamp)
        } else {
            filteredRequests.append(request)
        }

        ipRequests[request.ip] = existingTimestamps
    }

    return filteredRequests
}

// Example Usage
let requests = [
    Request(timestamp: 50000, ip: "192.168.1.1"),
    Request(timestamp: 50000, ip: "192.168.1.1"),
    Request(timestamp: 50000, ip: "192.168.1.2"),
    Request(timestamp: 50250, ip: "192.168.1.1"),
    Request(timestamp: 50500, ip: "192.168.1.2"),
    Request(timestamp: 50750, ip: "192.168.1.1"),
    Request(timestamp: 50850, ip: "192.168.1.2"),
    Request(timestamp: 50850, ip: "192.168.1.2"),
    Request(timestamp: 50900, ip: "192.168.1.2"),
    Request(timestamp: 51250, ip: "192.168.1.1"),
    Request(timestamp: 51900, ip: "192.168.1.2"),
]

/*
for request in ignoringRequests(requests, limitPerSecond: 3) {
    print("\(request.timestamp) - \(request.ip)")
}
*/


