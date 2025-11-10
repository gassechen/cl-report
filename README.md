# cl-report: Web Report Builder

`cl-report` is a dynamic, web-based report and dashboard builder written in Common Lisp. It allows users to create projects, fetch data from JSON APIs, and construct interactive dashboards using a variety of widgets. The frontend is powered by HTMX for seamless UI updates, providing a responsive and modern user experience.

## Features

- **Project Management**: Create, save, and load report projects.
- **Dynamic Dashboards**: Build dashboards with draggable and resizable widgets.
- **Data Integration**: Fetch and process data from JSON-based URLs.
- **Rich Widget Library**:
    - Interactive Tables with sorting and pagination.
    - Charts, including line and pie charts.
    - Gauges (Linear and Radial) for metric visualization.
    - Google Maps with markers.
    - Text editors, image galleries, video galleries, and more.
- **SQL Queries**: Run SQL queries directly on the loaded data.
- **Modern Frontend**: A highly interactive UI built with HTMX and the UIkit CSS framework.

## Tech Stack

### Backend
- **Language**: Common Lisp (SBCL recommended)
- **Web Server**: Hunchentoot
- **Routing**: easy-routes
- **Database**: SQLite (via the Mito ORM)
- **HTML Generation**: Spinneret
- **Dataframes**: lisp-stat, data-frame
- **SQL on Dataframes**: sqldf

### Frontend
- **Core**: HTMX
- **Styling**: UIkit
- **JavaScript Libraries**: jQuery, jQuery UI, Tabulator, Vega/Vega-Lite, Ace Editor, SweetAlert2

## Prerequisites

- A Common Lisp implementation, such as [SBCL](http://www.sbcl.org/platform-table.html).
- [Quicklisp](https://www.quicklisp.org/beta/).
- The `libsqlite3` shared library.

## Installation and Running

1.  **Clone the Repository**:
    Clone this project into your Quicklisp local-projects directory.
    ```bash
    git clone <repository-url> ~/quicklisp/local-projects/cl-report
    ```

2.  **Install Dependencies**:
    Start your Lisp REPL and use Quicklisp to install the project dependencies.
    ```lisp
    (ql:quickload :cl-report)
    ```
    This will download and install all the required libraries listed in `cl-report.asd`.

3.  **Run the Application**:
    Once all dependencies are installed, start the server from the REPL.
    ```lisp
    (cl-report:main)
    ```
    The server will start on `http://localhost:8000` by default.

4.  **Access the Application**:
    Open your web browser and navigate to `http://localhost:8000`.

## Basic Usage

1.  **Create a New Project**: From the main page, click "New" to open the "New Report" modal. Give your project a name.
2.  **Add a Data Source**: A new modal will appear to add a URL for your JSON data source. Enter a valid URL that returns JSON data.
3.  **Build the Form**: The application will inspect the JSON source and generate a form. You can use this form to fetch data.
4.  **Add Widgets**: Use the "Widgets" sidebar to add various components to your dashboard.
5.  **Configure Widgets**: Click the gear icon on any widget to open its configuration modal.
6.  **Save**: Click the "Save" button in the top menu to persist your dashboard layout and configuration.
7.  **Load**: From the main page, click "Load" to see a list of your saved projects.