import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { PageContainer, Card, ErrorMessage, SuccessMessage } from '../styles/CommonStyles';
import styled from 'styled-components';

const RegisterContainer = styled.div`
  max-width: 400px;
  margin: 0 auto;
  padding: 2rem 0;
`;

const RegisterCard = styled(Card)`
  text-align: center;
`;

const Title = styled.h1`
  color: #2c3e50;
  margin-bottom: 2rem;
  font-size: 2rem;
`;

const Form = styled.form`
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
`;

const FormGroup = styled.div`
  display: flex;
  flex-direction: column;
  text-align: left;
`;

const Label = styled.label`
  margin-bottom: 0.5rem;
  font-weight: 600;
  color: #2c3e50;
`;

const Input = styled.input`
  padding: 12px;
  border: 2px solid #e9ecef;
  border-radius: 8px;
  font-size: 16px;
  transition: border-color 0.3s;

  &:focus {
    outline: none;
    border-color: #3498db;
  }
`;

const SubmitButton = styled.button`
  background-color: #27ae60;
  color: white;
  border: none;
  padding: 12px;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s;

  &:hover {
    background-color: #219a52;
  }

  &:disabled {
    background-color: #bdc3c7;
    cursor: not-allowed;
  }
`;

const LoginLink = styled.div`
  margin-top: 2rem;
  color: #7f8c8d;
  
  a {
    color: #3498db;
    text-decoration: none;
    font-weight: 600;
    
    &:hover {
      text-decoration: underline;
    }
  }
`;

const Register = () => {
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    confirmPassword: ''
  });
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [loading, setLoading] = useState(false);
  
  const { register } = useAuth();
  const navigate = useNavigate();

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setSuccess('');

    if (formData.password !== formData.confirmPassword) {
      setError('Passwords do not match');
      return;
    }

    if (formData.password.length < 6) {
      setError('Password must be at least 6 characters long');
      return;
    }

    setLoading(true);

    const { confirmPassword, ...registerData } = formData;
    const result = await register(registerData);
    
    if (result.success) {
      setSuccess('Registration successful! Redirecting...');
      setTimeout(() => navigate('/dashboard'), 1000);
    } else {
      setError(result.error);
    }
    
    setLoading(false);
  };

  return (
    <PageContainer>
      <RegisterContainer>
        <RegisterCard>
          <Title>Create Account</Title>
          <p style={{ color: '#7f8c8d', marginBottom: '2rem' }}>
            Join Enterprise Task Manager today
          </p>

          {error && <ErrorMessage>{error}</ErrorMessage>}
          {success && <SuccessMessage>{success}</SuccessMessage>}

          <Form onSubmit={handleSubmit}>
            <FormGroup>
              <Label htmlFor="firstName">First Name</Label>
              <Input
                type="text"
                id="firstName"
                name="firstName"
                value={formData.firstName}
                onChange={handleChange}
                required
                placeholder="Enter your first name"
              />
            </FormGroup>

            <FormGroup>
              <Label htmlFor="lastName">Last Name</Label>
              <Input
                type="text"
                id="lastName"
                name="lastName"
                value={formData.lastName}
                onChange={handleChange}
                required
                placeholder="Enter your last name"
              />
            </FormGroup>

            <FormGroup>
              <Label htmlFor="email">Email Address</Label>
              <Input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                required
                placeholder="Enter your email"
              />
            </FormGroup>

            <FormGroup>
              <Label htmlFor="password">Password</Label>
              <Input
                type="password"
                id="password"
                name="password"
                value={formData.password}
                onChange={handleChange}
                required
                placeholder="Enter your password"
                minLength="6"
              />
            </FormGroup>

            <FormGroup>
              <Label htmlFor="confirmPassword">Confirm Password</Label>
              <Input
                type="password"
                id="confirmPassword"
                name="confirmPassword"
                value={formData.confirmPassword}
                onChange={handleChange}
                required
                placeholder="Confirm your password"
                minLength="6"
              />
            </FormGroup>

            <SubmitButton type="submit" disabled={loading}>
              {loading ? 'Creating Account...' : 'Create Account'}
            </SubmitButton>
          </Form>

          <LoginLink>
            Already have an account? <Link to="/login">Sign in here</Link>
          </LoginLink>
        </RegisterCard>
      </RegisterContainer>
    </PageContainer>
  );
};

export default Register;