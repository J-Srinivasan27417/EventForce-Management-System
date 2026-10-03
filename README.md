# EventForce Management System

Salesforce team project for managing events, clients, vendors, venues, and feedback.

## Implementation

Built in a dedicated Trailhead Playground using six custom objects: Event, Client, Vendor, Venue, Feedback, and Event Vendor. The implementation includes venue-booking logic, cancellation approval, a three-day reminder flow, scheduled event completion, role-based access, reports, and a dashboard.

## Download and read

Open [the project report](EventForce_Project_Report.pdf) directly. Download and extract [the project files](EventForce-GitHub-Upload.zip) to browse the source, tests, sample CSVs and configuration. The following paths refer to the extracted archive.

## Repository contents

- `documentation/EventForce_Project_Report.pdf`: implementation report and evidence; layout revision pending.
- `force-app/main/default`: available Apex classes, tests, trigger, and field metadata.
- `data`: fictional sample CSVs used for data-import demonstrations.
- `sfdx-project.json`: Salesforce project configuration.

## Validation status

The project work log records six project Apex tests passing on 3 October 2026, successful approval/rejection demonstrations, and six sample imports with zero failures. Actual email receipt and separate user-session access tests remain unverified.

## Source completeness

This is a partial source snapshot, not a complete deployable Salesforce export. Custom-object definitions and other configuration metadata, including flows, approval processes, profiles, sharing, reports, and dashboards, must be retrieved from the project org before a clean-org deployment can be reproduced. Do not deploy this folder as a complete application.

## Demo video

The requested live Salesforce recording and team voiceover are pending. No screenshot slideshow is included as a substitute.

## Guide-specific behavior

The scheduled batch marks past events as Completed whenever their status is not already Completed, including Canceled and Rejected records, matching the supplied guide's stated rule.

## Data

CSV records are fictional training samples. Do not add credentials, Salesforce session files, password-reset links, or personal user-account exports to this public repository.
