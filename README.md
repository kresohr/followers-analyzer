# Follower Analyzer

## What is Follower Analyzer?

It is a simple tool that you run locally to check which users are **NOT** following you back on Instagram.

## How it works?

Follow these steps:

- Open the Instagram application
- Go to your profile
- Press on the "three lines" in the upper right corner
- Select 'Accounts Center'
- Select 'Your information and permission' in the Account Settings section
- Select 'Download your information'
- Select 'Download or transfer information'
- Select "Some of your information"
- Scroll down and select only "Followers and following" checkbox.
- Select 'Next'
- Select either 'Download to device' or 'Transfer to destination'
- For the date range, select 'All time'
- For the format, select 'JSON'
- Select 'Next'

Your files will become available on that screen within 24 hours, come back and you'll see a "download" button. Once you download the files, transfer them to the device you'll be uploading from. This file will be uploaded to the project you are going to run and it will show you a list of profiles which are not following you back.

## Running the project

There are two ways we can run this project locally. The first way is running it through terminal after installing all the requirements. The second way is by using docker image.

### Run via Terminal

First, make sure you clone the project from this repository.

Ensure you have the following installed:

- [Node.js](https://nodejs.org/en/download) (At least version 18)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Git](https://git-scm.com/downloads)
- [Visual Studio Code](https://code.visualstudio.com/) (or any IDE of your choice)

Run this in terminal where you want to clone the project

```
git clone https://github.com/kresohr/followers-analyzer.git
```

After the project has been cloned, we need to install all the npm packages that are needed for the project. We can do that by running the following npm command in root.

```
npm install
```

Then, to start the actual project we can use the following command:

```
npm run dev
```

### Run via Docker

To run the project using Docker, ensure that Docker Desktop is installed and running on your machine. Then, follow these steps:

1. Open your terminal.
2. Navigate to the directory where you cloned the repository.
3. Make sure you are in the projects root folder
4. Build the Docker image with the following command:

   ```
   docker compose build --no-cache
   ```

5. Run the Docker container:

   ```
   docker compose up
   ```

6. The application is running and you can access it on the following link

   ```
   http://localhost:3000/
   ```
