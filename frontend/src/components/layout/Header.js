import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import styled from 'styled-components';

const HeaderContainer = styled.header`
  background-color: #2c3e50;
  color: white;
  padding: 1rem 0;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
`;

const Nav = styled.nav`
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
`;

const Logo = styled(Link)`
  font-size: 1.5rem;
  font-weight: bold;
  color: white;
  text-decoration: none;
  
  &:hover {
    color: #3498db;
  }
`;

const NavLinks = styled.div`
  display: flex;
  align-items: center;
  gap: 2rem;
`;

const NavLink = styled(Link)`
  color: white;
  text-decoration: none;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  transition: background-color 0.3s;

  &:hover {
    background-color: #34495e;
  }
`;

const LogoutButton = styled.button`
  background-color: #e74c3c;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;

  &:hover {
    background-color: #c0392b;
  }
`;

const UserInfo = styled.span`
  color: #ecf0f1;
  font-size: 0.9rem;
`;

const Header = () => {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <HeaderContainer>
      <Nav>
        <Logo to="/">
          🚀 Enterprise App - Sabin Rana
        </Logo>
        
        <NavLinks>
          {user ? (
            <>
              <NavLink to="/dashboard">Dashboard</NavLink>
              <NavLink to="/tasks">Tasks</NavLink>
              <NavLink to="/profile">Profile</NavLink>
              <UserInfo>Welcome, {user.firstName}!</UserInfo>
              <LogoutButton onClick={handleLogout}>Logout</LogoutButton>
            </>
          ) : (
            <>
              <NavLink to="/login">Login</NavLink>
              <NavLink to="/register">Register</NavLink>
            </>
          )}
        </NavLinks>
      </Nav>
    </HeaderContainer>
  );
};

export default Header;