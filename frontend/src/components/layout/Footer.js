import React from 'react';
import styled from 'styled-components';

const FooterContainer = styled.footer`
  background-color: #34495e;
  color: white;
  padding: 2rem 0;
  margin-top: auto;
`;

const FooterContent = styled.div`
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
`;

const Copyright = styled.p`
  margin: 0;
  font-size: 0.9rem;
`;

const ProjectInfo = styled.div`
  text-align: right;
  
  p {
    margin: 0.25rem 0;
    font-size: 0.8rem;
    color: #bdc3c7;
  }
`;

const Footer = () => {
  return (
    <FooterContainer>
      <FooterContent>
        <Copyright>
          © 2025 Enterprise Task Manager. All rights reserved.
        </Copyright>
        <ProjectInfo>
          <p>Sabin Rana</p>
          <p>AWS 3-Tier Architecture Project</p>
          <p>Portfolio Demonstration</p>
        </ProjectInfo>
      </FooterContent>
    </FooterContainer>
  );
};

export default Footer;