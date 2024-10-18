STATS is a customizable personal statistic tracking mobile application developed using Swift, SwiftUI, and UIKit. This project was the final submission for a master’s degree and focuses on tracking personal statistics across various activities. The app also integrates with the camera for data input and utilizes local storage with SwiftData.

Features

- Track personal statistics with customizable categories.
- Use the camera to input relevant data.
- Data persistence and management using SwiftData.

Technologies Used

- Swift: Primary programming language.
- SwiftUI & UIKit: For building the user interface.
- SwiftData: Local data storage and management.

Architecture

- Model-View Pattern: Experimented with the Model-View architecture due to SwiftData limitations. Extended models with static functions tailored to specific data-fetching needs. This strategy proved effective, simplifying unit testing and improving maintainability.

