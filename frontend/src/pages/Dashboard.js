import React from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { PageContainer, Card } from '../styles/CommonStyles';
import styled from 'styled-components';

const WelcomeSection = styled.div`
  text-align: center;
  margin-bottom: 3rem;
  
  h1 {
    color: #2c3e50;
    margin-bottom: 1rem;
    font-size: 2.5rem;
  }
  
  p {
    color: #7f8c8d;
    font-size: 1.2rem;
    max-width: 600px;
    margin: 0 auto;
  }
`;

const QuickActions = styled.div`
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  margin-bottom: 3rem;
`;

const ActionCard = styled(Link)`
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 2rem;
  border-radius: 15px;
  text-decoration: none;
  text-align: center;
  transition: transform 0.3s, box-shadow 0.3s;
  
  &:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
  }
  
  h3 {
    margin-bottom: 1rem;
    font-size: 1.5rem;
  }
  
  p {
    opacity: 0.9;
  }
`;

const StatsSection = styled.div`
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
`;

const StatCard = styled(Card)`
  text-align: center;
  
  h3 {
    color: #7f8c8d;
    font-size: 0.9rem;
    text-transform: uppercase;
    margin-bottom: 0.5rem;
  }
  
  .stat-value {
    font-size: 2.5rem;
    font-weight: bold;
    color: #2c3e50;
  }
`;

const Dashboard = () => {
  const { user } = useAuth();

  return (
    <PageContainer>
      <WelcomeSection>
        <h1>Welcome back, {user?.firstName}!
</h1>
        <p>
          Manage your tasks efficiently with our enterprise-grade task management system. 
          Built on AWS cloud infrastructure for maximum reliability and performance.
        </p>
      </WelcomeSection>

      <QuickActions>
        <ActionCard to="/tasks">
          <h3>📋 Task Manager</h3>
          <p>Create, organize, and track your tasks</p>
        </ActionCard>
        
        <ActionCard to="/profile">
          <h3>👤 Your Profile</h3>
          <p>Update your personal information</p>
        </ActionCard>
      </QuickActions>

      <StatsSection>
        <StatCard>
          <h3>Total Tasks</h3>
          <div className="stat-value">0</div>
          <p>Get started by creating your first task!</p>
        </StatCard>
        
        <StatCard>
          <h3>Completed</h3>
          <div className="stat-value">0</div>
          <p>Tasks marked as done</p>
        </StatCard>
        
        <StatCard>
          <h3>In Progress</h3>
          <div className="stat-value">0</div>
          <p>Tasks being worked on</p>
        </StatCard>
        
        <StatCard>
          <h3>Pending</h3>
          <div className="stat-value">0</div>
          <p>Tasks waiting to start</p>
        </StatCard>
      </StatsSection>
    </PageContainer>
  );
};

export default Dashboard;