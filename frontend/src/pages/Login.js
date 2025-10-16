import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { PageContainer, Card, ErrorMessage, SuccessMessage } from '../styles/CommonStyles';
import styled from 'styled-components';

const LoginContainer = styled.div`
  max-width: 400px;
  margin: 0 auto;
  padding: 2rem 0;
`;

const LoginCard = styled(Card)`
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
  background-color: #3498db;
  color: white;
  border: none;
  padding: 12px;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s;

  &:hover {
    background-color: #2980b9;
  }

  &:disabled {
    background-color: #bdc3c7;
    cursor: not-allowed;
  }
`;

const RegisterLink = styled.div`
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

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [loading, setLoading] = useState(false);
  
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setSuccess('');
    setLoading(true);

    const result = await login({ email, password });
    
    if (result.success) {
      setSuccess('Login successful! Redirecting...');
      setTimeout(() => navigate('/dashboard'), 1000);
    } else {
      setError(result.error);
    }
    
    setLoading(false);
  };

  return (
    <PageContainer>
      <LoginContainer>
        <LoginCard>
          <Title>Welcome Back</Title>
          <p style={{ color: '#7f8c8d', marginBottom: '2rem' }}>
            Sign in to your Enterprise Task Manager account
          </p>

          {error && <ErrorMessage>{error}</ErrorMessage>}
          {success && <SuccessMessage>{success}</SuccessMessage>}

          <Form onSubmit={handleSubmit}>
            <FormGroup>
              <Label htmlFor="email">Email Address</Label>
              <Input
                type="email"
                id="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                placeholder="Enter your email"
              />
            </FormGroup>

            <FormGroup>
              <Label htmlFor="password">Password</Label>
              <Input
                type="password"
                id="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                placeholder="Enter your password"
              />
            </FormGroup>

            <SubmitButton type="submit" disabled={loading}>
              {loading ? 'Signing In...' : 'Sign In'}
            </SubmitButton>
          </Form>

          <RegisterLink>
            Don't have an account? <Link to="/register">Create one here</Link>
          </RegisterLink>
        </LoginCard>
      </LoginContainer>
    </PageContainer>
  );
};

export default Login;