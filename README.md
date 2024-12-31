# SwiftJiraMockServer

Mock Jira API for testing SwiftJiraKit, built with Swift and Vapor. Ideal for local and CI testing.

## Features

- Simulates Jira API behavior for endpoints like issue retrieval and creation.
- Lightweight and written in Swift using the Vapor framework.
- Fully customizable to fit diverse testing scenarios.
- Dockerized for easy deployment in local and CI environments.

## Getting Started

### Prerequisites

- Swift 5.7 or later
- Docker (optional, for containerized deployment)

### Build and Run Locally

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/SwiftJiraMockServer.git
   cd SwiftJiraMockServer
   ```

2. Build and run the server:

   ```bash
   swift run
   ```

3. The server runs on `http://localhost:8080` by default.

### Using Docker

1. Build the Docker image:

   ```bash
   docker build -t swiftjira-mock-server .
   ```

2. Run the container:

   ```bash
   docker run -p 8080:8080 swiftjira-mock-server
   ```

## Example Endpoints

### Retrieve an Issue

```bash
GET /rest/api/2/issue/:issueId
```

Returns a mock issue with the provided `issueId`.

### Create an Issue

```bash
POST /rest/api/2/issue
```

Returns a mock response for issue creation.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Contributions

Contributions are welcome! Please open issues or submit pull requests for improvements or new features.

