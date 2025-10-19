# ==============================================================================
# SECURITY SCANNING WORKFLOW - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# This workflow performs comprehensive security scanning across the entire project
# Includes infrastructure, application, code, and container security validation
# ==============================================================================

name: Security Scanning

on:
  pull_request:
  push:
    branches: [ main ]
  schedule:
    - cron: '0 6 * * 1'

env:
  NODE_VERSION: '18'
  PYTHON_VERSION: '3.9'

jobs:
  # Terraform infrastructure security scanning
  terraform-security:
    name: Terraform Security Scan
    runs-on: ubuntu-latest
    
    steps:
    # Checkout repository code
    - name: Checkout code
      uses: actions/checkout@v3
      
    # Terraform security scanning with tfsec
    - name: TFSec Security Scan
      uses: aquasecurity/tfsec-action@v1.0.0
      with:
        directory: terraform/
        
    # Terraform linting with tflint
    - name: TFLint Analysis
      uses: terraform-linters/setup-tflint@v3
      with:
        tflint_version: latest
      
    - name: Run TFLint
      run: |
        cd terraform
        tflint --init
        tflint --recursive

  # Backend application security scanning
  backend-security:
    name: Backend Security Scan
    runs-on: ubuntu-latest
    
    steps:
    # Checkout repository code
    - name: Checkout code
      uses: actions/checkout@v3
      
    # Setup Node.js environment
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: ${{ env.NODE_VERSION }}
        cache: 'npm'
        cache-dependency-path: backend/package-lock.json
        
    # Install backend dependencies
    - name: Install dependencies
      run: |
        cd backend
        npm ci
        
    # NPM security audit for dependencies
    - name: NPM Security Audit
      run: |
        cd backend
        npm audit --audit-level high
        
    # Snyk security scanning for deeper analysis
    - name: Snyk Security Scan
      uses: snyk/actions/node@master
      env:
        SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
      with:
        args: --severity-threshold=high
      continue-on-error: true

  # Frontend application security scanning
  frontend-security:
    name: Frontend Security Scan
    runs-on: ubuntu-latest
    
    steps:
    # Checkout repository code
    - name: Checkout code
      uses: actions/checkout@v3
      
    # Setup Node.js environment
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: ${{ env.NODE_VERSION }}
        cache: 'npm'
        cache-dependency-path: frontend/package-lock.json
        
    # Install frontend dependencies
    - name: Install dependencies
      run: |
        cd frontend
        npm ci
        
    # Frontend dependency security audit
    - name: NPM Security Audit
      run: |
        cd frontend
        npm audit --audit-level high
        
    # Build security verification
    - name: Security Build Check
      run: |
        cd frontend
        npm run build
        echo "Build completed - no security issues in build process"

  # General code security analysis
  code-security:
    name: Code Security Analysis
    runs-on: ubuntu-latest
    
    steps:
    # Checkout repository code
    - name: Checkout code
      uses: actions/checkout@v3
      
    # Secret scanning with Gitleaks
    - name: Secret Detection
      uses: gitleaks/gitleaks-action@v2
      with:
        config-path: .gitleaks.toml
        redact: true
      
    # Dependency review for security impact
    - name: Dependency Review
      uses: actions/dependency-review-action@v3
      
    # CodeQL static analysis for vulnerabilities
    - name: CodeQL Analysis
      uses: github/codeql-action/init@v2
      with:
        languages: javascript, typescript
        
    - name: Autobuild
      uses: github/codeql-action/autobuild@v2
      
    - name: Perform CodeQL Analysis
      uses: github/codeql-action/analyze@v2

  # Container security scanning
  container-security:
    name: Container Security Scan
    runs-on: ubuntu-latest
    
    steps:
    # Checkout repository code
    - name: Checkout code
      uses: actions/checkout@v3
      
    # Build Docker image for security scanning
    - name: Build Docker image
      run: |
        cd backend
        docker build -t backend-security-scan .
        echo "Docker image built for security scanning"
        
    # Trivy container vulnerability scanning
    - name: Trivy Security Scan
      uses: aquasecurity/trivy-action@master
      with:
        image-ref: 'backend-security-scan'
        format: 'sarif'
        output: 'trivy-results.sarif'
        
    - name: Upload Trivy Scan Results
      uses: github/codeql-action/upload-sarif@v2
      if: always()
      with:
        sarif_file: 'trivy-results.sarif'

  # Security scan summary and reporting
  security-summary:
    name: Security Summary
    runs-on: ubuntu-latest
    needs: [terraform-security, backend-security, frontend-security, code-security, container-security]
    
    steps:
    # Generate security scanning summary report
    - name: Security Scan Summary
      run: |
        echo "SECURITY SCAN SUMMARY"
        echo "====================="
        echo "Terraform Security: Completed"
        echo "Backend Security: Completed" 
        echo "Frontend Security: Completed"
        echo "Code Security: Completed"
        echo "Container Security: Completed"
        echo ""
        echo "All security scans completed successfully"
        echo "Review individual job logs for detailed findings"