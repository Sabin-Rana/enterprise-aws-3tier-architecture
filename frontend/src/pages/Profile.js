import React from 'react';
import { useAuth } from '../contexts/AuthContext';
import { PageContainer, Card } from '../styles/CommonStyles';
import styled from 'styled-components';

const ProfileContainer = styled.div`
  max-width: 600px;
  margin: 0 auto;
`;

const ProfileCard = styled(Card)`
  text-align: center;
`;

const Avatar = styled.div`
  width: 100px;
  height: 100px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 50%;
  margin: 0 auto 1.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2rem;
  color: white;
  font-weight: bold;
`;

const UserName = styled.h1`
  color: #2c3e50;
  margin-bottom: 0.5rem;
  font-size: 2rem;
`;

const UserEmail = styled.p`
  color: #7f8c8d;
  font-size: 1.1rem;
  margin-bottom: 2rem;
`;

const InfoGrid = styled.div`
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
  margin-top: 2rem;
`;

const InfoCard = styled.div`
  background: #f8f9fa;
  padding: 1.5rem;
  border-radius: 10px;
  text-align: center;
  
  h3 {
    color: #7f8c8d;
    font-size: 0.9rem;
    text-transform: uppercase;
    margin-bottom: 0.5rem;
  }
  
  .value {
    font-size: 1.5rem;
    font-weight: bold;
    color: #2c3e50;
  }
`;

const ProjectInfo = styled.div`
  margin-top: 3rem;
  padding-top: 2rem;
  border-top: 2px solid #e9ecef;
  
  h2 {
    color: #2c3e50;
    margin-bottom: 1rem;
  }
  
  p {
    color: #7f8c8d;
    line-height: 1.6;
  }
`;

const Profile = () => {
  const { user } = useAuth();

  const getInitials = (firstName, lastName) => {
    return `${firstName?.charAt(0) || ''}${lastName?.charAt(0) || ''}`.toUpperCase();
  };

  return (
    <PageContainer>
      <ProfileContainer>
        <ProfileCard>
          <Avatar>
            {getInitials(user?.firstName, user?.lastName)}
          </Avatar>
          
          <UserName>
            {user?.firstName} {user?.lastName}
          </UserName>
          
          <UserEmail>
            {user?.email}
          </UserEmail>

          <InfoGrid>
            <InfoCard>
              <h3>Member Since</h3>
              <div className="value">Today</div>
            </InfoCard>
            
            <InfoCard>
              <h3>Total Tasks</h3>
              <div className="value">0</div>
            </InfoCard>
            
            <InfoCard>
              <h3>Completed</h3>
              <div className="value">0</div>
            </InfoCard>
          </InfoGrid>

          <ProjectInfo>
            <h2>About This Project</h2>
            <p>
              This Enterprise Task Manager is built on a complete AWS 3-Tier Architecture, 
              featuring scalable cloud infrastructure, secure authentication, and 
              production-ready deployment. The application demonstrates full-stack 
              development expertise with React frontend, Node.js backend, and 
              PostgreSQL database.
            </p>
            <p style={{ marginTop: '1rem', fontStyle: 'italic' }}>
              Built by Sabin Rana as a portfolio demonstration of cloud architecture 
              and modern web development practices.
            </p>
          </ProjectInfo>
        </ProfileCard>
      </ProfileContainer>
    </PageContainer>
  );
};

export default Profile;