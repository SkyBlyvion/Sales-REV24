# Sales Extension for Business Central

### Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Features](#features)
- [Usage](#usage)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license)
  
---

## Overview

**Sales Extension** is a Business Central extension developed by **Lopez Nicolas - REVIMPORT**. The initial version of this extension allows for the handling of Sales Header and Sales Line data, with plans to extend support for additional entities in the future.

## Installation

To install the extension in your Business Central environment, follow these steps:

1. Download the `.app` file from the repository or obtain it from the publisher.
2. In Business Central, navigate to **Extensions** > **Manage** > **Upload Extension**.
3. Choose the downloaded `.app` file and click **Deploy**.

> **Requirements**: 
> - Business Central version 24.5.0.0 or higher.
> - Platform version 1.0.0.0 or higher.

## Features

- **Sales Header Integration**: Access and manage data related to sales headers.
- **Sales Line Integration**: Access and manage data associated with individual sales lines.

Future updates will include additional functionality as the extension expands.

## Usage

Once installed, the Sales extension can be accessed directly from the Sales module in Business Central. You can manage and interact with Sales Headers and Sales Lines seamlessly.

## Configuration

IdRanges :
    - 51000
    - tableextension 51001 SalesHeaderTableExt extends "Sales Header"
    - table 51002 TypeOrigine
    - permissionset 51003 "SalesPerms"
    - page 51004 "TypeOrigine"
    - enum 51005 NatureEnum
    - tableextension 51006 "SalesLineTableExt" extends "Sales Line"
    - codeunit 51007 "Revimport Reservation"



### Example Code Snippets

```al
// Example AL code 
