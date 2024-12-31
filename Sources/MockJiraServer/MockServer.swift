import Foundation
import Vapor

// Configure the Vapor app
public func configure(_ app: Application) throws {
    // Handle routes under `/rest/api/2/issue/:parameterName`
    app.on(.GET, "rest", "api", "2", "issue", ":parameterName", "**") { req -> Response in
        guard let parameterName = req.parameters.get("parameterName") else {
            return Response(status: .badRequest)
        }
        
        // Determine the trailing path after the parameter
        let trailingPath = req.parameters.getCatchall().joined(separator: "/")
        
        switch trailingPath {
        case "info":
            // Fetch issue details
            let mockResponse: [String: Any] = [
                "id": parameterName,
                "key": "TEST-\(parameterName)",
                "fields": [
                    "summary": "Mock issue summary",
                    "description": "This is a mocked Jira issue."
                ]
            ]
            return Response(
                status: .ok,
                headers: .init([("Content-Type", "application/json")]),
                body: .init(data: try! JSONSerialization.data(withJSONObject: mockResponse))
            )
            
        case "worklog":
            // Fetch worklogs for an issue
            let mockResponse: [String: Any] = [
                "issueKey": parameterName,
                "worklogs": [
                    ["id": "1", "author": "User A", "timeSpent": "1h"],
                    ["id": "2", "author": "User B", "timeSpent": "2h"]
                ]
            ]
            return Response(
                status: .ok,
                headers: .init([("Content-Type", "application/json")]),
                body: .init(data: try! JSONSerialization.data(withJSONObject: mockResponse))
            )
            
        default:
            return Response(status: .notFound)
        }
    }

    // Create a new issue
    app.post("rest", "api", "2", "issue") { req -> Response in
        let mockResponse: [String: Any] = [
            "id": "10001",
            "key": "TEST-10001",
            "self": "https://mockserver.example.com/rest/api/2/issue/10001"
        ]
        return Response(
            status: .created,
            headers: .init([("Content-Type", "application/json")]),
            body: .init(data: try! JSONSerialization.data(withJSONObject: mockResponse))
        )
    }

    // Validate connectivity
    app.get("rest", "api", "2", "serverInfo") { req -> Response in
        let mockResponse: [String: Any] = [
            "version": "8.13.0",
            "deploymentType": "Cloud"
        ]
        return Response(
            status: .ok,
            headers: .init([("Content-Type", "application/json")]),
            body: .init(data: try! JSONSerialization.data(withJSONObject: mockResponse))
        )
    }
}

// Function to start the server
public struct MockServer {
    public static func main() throws {
        var env = try Environment.detect()
        try LoggingSystem.bootstrap(from: &env)
        let app = Application(env)
        defer { app.shutdown() }

        // Bind the server to all interfaces
        app.http.server.configuration.hostname = "0.0.0.0"

        // Configure the app
        try configure(app)
        try app.run()
    }
}

