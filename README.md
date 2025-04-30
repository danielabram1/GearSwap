# GearSwap: Outdoor Equipment Sharing Platform

GearSwap is a decentralized peer-to-peer platform built on blockchain technology that enables outdoor enthusiasts to share adventure equipment with others in their community.

## Overview

GearSwap creates a sharing economy for outdoor gear, reducing waste and making adventure more accessible. The platform allows users to list equipment they're willing to share, specify details like condition and loan duration, and connect with fellow adventurers who need gear for their next trip.

## Features

- Create equipment listings with detailed information (name, description, category, condition)
- Specify maximum loan duration for equipment
- Remove listings when equipment is no longer available
- Browse available gear by category, condition, or owner
- Transparent ownership tracking

## Contract Functions

### Public Functions

- `list-equipment`: Add outdoor gear to the sharing platform
- `remove-equipment`: Remove equipment from active listings
- `get-equipment`: Retrieve details about specific gear
- `get-owner`: Get the owner of specific equipment

### Constants

- Minimum loan duration requirements
- Validation for equipment categories and conditions
- Error codes for various failure scenarios

## Data Structure

Each equipment listing contains:
- Owner information (principal)
- Equipment name (string)
- Description (string)
- Category classification
- Physical condition
- Availability status
- Maximum loan duration in days

## Getting Started

To interact with the GearSwap platform:

1. Deploy the contract to a Stacks blockchain node
2. Call the contract functions using a compatible wallet or Clarity development environment
3. Create listings for equipment you wish to share
4. Browse available gear from other outdoor enthusiasts

## Future Development

- Implement direct equipment borrowing functionality
- Add user rating system for lenders and borrowers
- Create equipment insurance and deposit system
- Develop maintenance and condition reporting