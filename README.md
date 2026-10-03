# EventForce Management System

Salesforce team project for managing events, clients, vendors, venues, and feedback, built in a dedicated Trailhead Playground.

## Review the project

- [Project Document](Project%20Document/EventForce_Project_Report.pdf): implementation report, screenshots and testing evidence.
- [Code Files](Code%20Files): available Apex classes, tests, trigger, field metadata and fictional sample CSVs.

- [Phase-wise Documents](Phase-wise%20Documents): five phase documents covering planning, backend, UI, testing/security and deployment/maintenance.

## Features

Six custom objects support event planning, client and vendor records, venue allocation and feedback. Automation includes venue-booking checks, cancellation approval, client notifications, a three-day reminder, and scheduled completion of past events. The org also includes roles, profiles, permission sets, sharing rules, a report and a dashboard.

## Verification

The project work log records six project Apex tests passing on 3 October 2026, successful approval/rejection demonstrations and six imports with zero failures. Actual email receipt and separate user-session access tests remain unverified.

## Source scope

The source folder is a partial snapshot, not a complete deployable org export. Flows, approvals, security configuration, reports, dashboards and custom-object definitions still require retrieval from the org for a reproducible deployment. The report documents the implemented configuration.

## Demo video

The live Salesforce recording and team voiceover are pending.

## Guide-specific behavior

The daily batch completes past events whose status is not Completed, including Canceled and Rejected records, following the supplied guide's rule.

## Data

The CSV files contain fictional training records. Credentials and Salesforce authentication files must not be committed.
