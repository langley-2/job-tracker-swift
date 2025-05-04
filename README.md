# Job Tracker

**Job Tracker** is a SwiftUI app I built to keep my job search organised. It helps me stay on top of every opportunity — from spotting a role to receiving an offer (or not). The goal was to streamline the entire application process and give myself a clearer sense of progress and direction.

## What It Does

- Keeps all job applications in one place
- Tracks the status of each role — from discovery to final outcome
- Stores useful details like contacts, notes, and links
- Displays visual indicators for quick status checks
- Offers contextual prompts based on where I’m up to with each role
- Uses a clean tab-based layout for easy navigation

## Status Workflow

Each job moves through defined stages:

- **Discovered** – spotted a role worth exploring
- **Researching** – looking into the company and role
- **Outreach** – making contact with someone at the organisation
- **Applied** – application submitted
- **Interviewing** – in active interview stages
- **Offer** – received an offer
- **Accepted** – offer accepted
- **Rejected** – unsuccessful application
- **Closed** – process wrapped up (e.g. role filled, no longer interested)

## Job Detail Tracking

Each job entry includes:

- Job title
- Organisation name
- URL to the listing
- Contact person (if any)
- Status flags (research, outreach, application)
- Current stage
- Notes field for anything relevant

## Tech Stack

- **SwiftUI** for the interface
- **Swift 5**
- **UserDefaults** for lightweight persistence (with plans to move to Core Data or SwiftData)
- Compatible with iOS 15.0 and above

## In Action

The app uses colour-coded indicators and subtle visual cues (like progress dots) to show where each application stands. The detailed view highlights what’s next — whether that’s researching the company, following up, or preparing for an interview.

## In Development

I’m currently working on several enhancements, including:

- **AI-powered job discovery**, surfacing relevant roles based on skills, preferences, and history
- **Smart autofill**, extracting job details automatically from URLs or job boards
- Improved data storage using **Core Data or SwiftData**
- Expanded guidance and in-app tips tailored to each stage of the application process
