# Application Configuration Template

This directory contains configuration files for [Application Name].

## Structure

```
.
├── config.yaml       # Main configuration file
├── README.md        # This file
└── scripts/         # Application-specific scripts
```

## Configuration Files

- `config.yaml`: Main configuration file
  - Description of configuration options
  - Default values
  - Environment variables used

## Usage

1. Copy this template directory to create a new application configuration:
   ```bash
   cp -r template/ new_app_name/
   ```
2. Modify the configuration files as needed
3. Update this README with application-specific information

## Environment Variables

List any environment variables that need to be set:

- `APP_NAME_CONFIG`: Path to the configuration file
- `APP_NAME_ENV`: Environment (development, production, etc.)

## Security Considerations

- Document any sensitive configuration items
- Specify which files should not be committed to version control
- List any encryption requirements

## Testing

Describe how to test the configuration:

```bash
make test APP=new_app_name
```

## Deployment

Instructions for deploying the configuration:

```bash
make deploy APP=new_app_name
```
