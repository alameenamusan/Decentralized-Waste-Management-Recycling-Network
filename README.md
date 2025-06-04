# Decentralized Waste Management Recycling Network

A comprehensive blockchain-based system for tracking waste through the recycling process, verifying facilities, monitoring environmental impact, and distributing incentives to promote sustainable waste management practices.

## Overview

This decentralized network consists of five interconnected smart contracts built on the Stacks blockchain using Clarity:

1. **Facility Verification Contract** - Validates and manages waste management facilities
2. **Waste Tracking Contract** - Tracks waste through the complete recycling process
3. **Material Recovery Contract** - Manages material recovery operations and inventory
4. **Environmental Impact Contract** - Monitors and tracks environmental impact metrics
5. **Incentive Distribution Contract** - Distributes rewards and incentives for recycling activities

## Features

### 🏭 Facility Management
- Register new waste management facilities
- Verify facilities through authorized validators
- Track facility status and capacity
- Manage facility permissions and authorizations

### 📦 Waste Tracking
- Create comprehensive waste tracking records
- Monitor waste status through the recycling pipeline
- Maintain complete audit trail of waste processing
- Track waste from collection to final recycling

### ♻️ Material Recovery
- Record material recovery operations
- Manage material inventory across facilities
- Track material quality grades
- Enable material transfers between facilities

### 🌱 Environmental Impact
- Monitor carbon savings and energy consumption
- Track water usage and waste diversion metrics
- Set and monitor environmental targets
- Calculate facility performance against goals

### 💰 Incentive System
- Distribute rewards for recycling activities
- Performance-based bonus incentives
- Transparent reward pool management
- Automated claim processing

## Smart Contract Architecture

### Contract Interactions

\`\`\`
┌─────────────────────┐    ┌─────────────────────┐
│ Facility            │◄──►│ Waste Tracking      │
│ Verification        │    │                     │
└─────────────────────┘    └─────────────────────┘
│                           │
▼                           ▼
┌─────────────────────┐    ┌─────────────────────┐
│ Material Recovery   │◄──►│ Environmental       │
│                     │    │ Impact              │
└─────────────────────┘    └─────────────────────┘
│                           │
▼                           ▼
┌─────────────────────────────────────────────────┐
│         Incentive Distribution                  │
└─────────────────────────────────────────────────┘
\`\`\`

## Getting Started

### Prerequisites

- Stacks blockchain node or access to testnet/mainnet
- Clarity CLI for contract deployment
- Node.js and npm for running tests

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd waste-management-network
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Contract Deployment

Deploy contracts in the following order to ensure proper dependencies:

1. Deploy Facility Verification Contract
2. Deploy Waste Tracking Contract
3. Deploy Material Recovery Contract
4. Deploy Environmental Impact Contract
5. Deploy Incentive Distribution Contract

\`\`\`bash
# Example deployment commands
clarinet deploy contracts/facility-verification.clar
clarinet deploy contracts/waste-tracking.clar
clarinet deploy contracts/material-recovery.clar
clarinet deploy contracts/environmental-impact.clar
clarinet deploy contracts/incentive-distribution.clar
\`\`\`

## Usage Examples

### Register a New Facility

\`\`\`clarity
(contract-call? .facility-verification register-facility
"Green Recycling Center"
"123 Eco Street, Green City"
"recycling"
u1000)
\`\`\`

### Create Waste Tracking Record

\`\`\`clarity
(contract-call? .waste-tracking create-waste-record
u1
"plastic"
u500)
\`\`\`

### Record Environmental Metrics

\`\`\`clarity
(contract-call? .environmental-impact record-environmental-metrics
u1
u202401
u1000
u500
u200
u800)
\`\`\`

### Claim Rewards

\`\`\`clarity
(contract-call? .incentive-distribution claim-rewards u1)
\`\`\`

## Data Structures

### Facility Record
- **facility-id**: Unique identifier
- **owner**: Principal address of facility owner
- **name**: Facility name
- **location**: Physical location
- **facility-type**: Type of facility (recycling, processing, etc.)
- **capacity**: Processing capacity
- **status**: Verification status
- **verified-at**: Verification timestamp
- **verifier**: Address of verifying authority

### Waste Item Record
- **waste-id**: Unique identifier
- **origin-facility**: Originating facility
- **current-facility**: Current location
- **waste-type**: Type of waste material
- **weight**: Weight in standard units
- **status**: Current processing status
- **created-at**: Creation timestamp
- **updated-at**: Last update timestamp
- **processor**: Current processor address

### Environmental Metrics
- **facility-id**: Facility identifier
- **period**: Reporting period
- **carbon-saved**: Carbon emissions saved
- **energy-consumed**: Energy consumption
- **water-used**: Water usage
- **waste-diverted**: Waste diverted from landfills
- **recycling-rate**: Calculated recycling efficiency

## Error Codes

| Code | Description |
|------|-------------|
| u100 | ERR_UNAUTHORIZED |
| u101 | ERR_FACILITY_EXISTS |
| u102 | ERR_FACILITY_NOT_FOUND |
| u103 | ERR_INVALID_STATUS |
| u200 | ERR_WASTE_NOT_FOUND |
| u201 | ERR_INVALID_STATUS |
| u202 | ERR_FACILITY_NOT_VERIFIED |
| u300 | ERR_RECOVERY_NOT_FOUND |
| u301 | ERR_INSUFFICIENT_MATERIAL |
| u400 | ERR_IMPACT_NOT_FOUND |
| u500 | ERR_INSUFFICIENT_FUNDS |
| u501 | ERR_INVALID_AMOUNT |
| u502 | ERR_REWARD_NOT_FOUND |

## Testing

The project includes comprehensive test suites for all contracts:

\`\`\`bash
# Run all tests
npm test

# Run specific test file
npm test facility-verification.test.js
npm test waste-tracking.test.js
npm test material-recovery.test.js
npm test environmental-impact.test.js
npm test incentive-distribution.test.js
\`\`\`

## Security Considerations

- All contracts implement proper authorization checks
- Facility verification required for critical operations
- Reward distribution includes balance validation
- Input validation on all public functions
- Protection against common smart contract vulnerabilities

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions, issues, or contributions, please:
- Open an issue on GitHub
- Contact the development team
- Review the documentation and test files

## Roadmap

- [ ] Integration with IoT sensors for automated waste tracking
- [ ] Mobile application for facility operators
- [ ] Advanced analytics dashboard
- [ ] Cross-chain compatibility
- [ ] Carbon credit tokenization
- [ ] Automated compliance reporting
