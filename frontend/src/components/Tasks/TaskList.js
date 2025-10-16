import React from 'react';
import styled from 'styled-components';

const TaskListContainer = styled.div`
  margin-top: 2rem;
`;

const EmptyState = styled.div`
  text-align: center;
  padding: 3rem;
  color: #7f8c8d;
  
  h3 {
    margin-bottom: 1rem;
    color: #2c3e50;
  }
`;

const TaskGrid = styled.div`
  display: grid;
  gap: 1rem;
`;

const TaskCard = styled.div`
  background: white;
  border-radius: 10px;
  padding: 1.5rem;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  border-left: 4px solid ${props => {
    switch (props.priority) {
      case 'high': return '#e74c3c';
      case 'medium': return '#f39c12';
      case 'low': return '#27ae60';
      default: return '#bdc3c7';
    }
  }};
`;

const TaskHeader = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 1rem;
`;

const TaskTitle = styled.h3`
  color: #2c3e50;
  margin: 0;
  flex: 1;
`;

const TaskActions = styled.div`
  display: flex;
  gap: 0.5rem;
`;

const ActionButton = styled.button`
  background: none;
  border: none;
  cursor: pointer;
  padding: 0.25rem;
  border-radius: 3px;
  transition: background-color 0.3s;
  
  &:hover {
    background-color: #f8f9fa;
  }
`;

const TaskDescription = styled.p`
  color: #7f8c8d;
  margin-bottom: 1rem;
  line-height: 1.5;
`;

const TaskMeta = styled.div`
  display: flex;
  gap: 1rem;
  font-size: 0.9rem;
  color: #7f8c8d;
`;

const StatusBadge = styled.span`
  background-color: ${props => {
    switch (props.status) {
      case 'completed': return '#27ae60';
      case 'in-progress': return '#3498db';
      default: return '#f39c12';
    }
  }};
  color: white;
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 600;
`;

const PriorityBadge = styled.span`
  background-color: ${props => {
    switch (props.priority) {
      case 'high': return '#e74c3c';
      case 'medium': return '#f39c12';
      case 'low': return '#27ae60';
      default: return '#bdc3c7';
    }
  }};
  color: white;
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 600;
`;

const DueDate = styled.span`
  color: ${props => {
    const dueDate = new Date(props.dueDate);
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    if (dueDate < today) return '#e74c3c';
    if (dueDate.getTime() === today.getTime()) return '#f39c12';
    return '#7f8c8d';
  }};
  font-weight: ${props => {
    const dueDate = new Date(props.dueDate);
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    return dueDate <= today ? '600' : '400';
  }};
`;

const TaskList = ({ tasks, onEdit, onDelete, isLoading }) => {
  const formatDate = (dateString) => {
    if (!dateString) return 'No due date';
    
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  };

  if (tasks.length === 0) {
    return (
      <TaskListContainer>
        <EmptyState>
          <h3>No tasks found</h3>
          <p>Create your first task to get started!</p>
        </EmptyState>
      </TaskListContainer>
    );
  }

  return (
    <TaskListContainer>
      <TaskGrid>
        {tasks.map((task) => (
          <TaskCard key={task.id} priority={task.priority}>
            <TaskHeader>
              <TaskTitle>{task.title}</TaskTitle>
              <TaskActions>
                <ActionButton 
                  onClick={() => onEdit(task)}
                  title="Edit task"
                >
                  ✏️
                </ActionButton>
                <ActionButton 
                  onClick={() => onDelete(task.id)}
                  title="Delete task"
                  disabled={isLoading}
                >
                  🗑️
                </ActionButton>
              </TaskActions>
            </TaskHeader>
            
            {task.description && (
              <TaskDescription>{task.description}</TaskDescription>
            )}
            
            <TaskMeta>
              <StatusBadge status={task.status}>
                {task.status.replace('-', ' ')}
              </StatusBadge>
              <PriorityBadge priority={task.priority}>
                {task.priority} priority
              </PriorityBadge>
              {task.due_date && (
                <DueDate dueDate={task.due_date}>
                  Due: {formatDate(task.due_date)}
                </DueDate>
              )}
            </TaskMeta>
          </TaskCard>
        ))}
      </TaskGrid>
    </TaskListContainer>
  );
};

export default TaskList;