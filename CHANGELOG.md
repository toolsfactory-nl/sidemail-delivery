# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
### Fixed
### Changed
### Removed

## [0.2.3] - 2025-03-05
### Added
- Support for cc and bcc, they will receive separate emails.

## [0.2.3] - 2025-02-28
### Fixed
- ActionMailer was loaded too early by this gem.

## [0.2.2] - 2024-10-23
### Fixed
- Error on successful delivery of mail to multiple receivers.

## [0.2.1] - 2024-09-26
### Fixed
- Nested structures in template properties.

## [0.2.0] - 2024-02-08
### Added
- Support for Sidemail templates and template properties.

## [0.1.2] - 2024-02-07
### Added
- Extended the information displayed by `Sidemail::Delivery::Exception`.

## [0.1.1] - 2024-02-01
### Fixed
- Homepage URL in gemspec.

## [0.1.0] - 2024-02-01
### Added
- Deliver ActionMailer mails through Sidemail API. 
