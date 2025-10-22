import React, { useState } from 'react';
import styled from 'styled-components';

const FilterContainer = styled.div`
  background: white;
  padding: 1.5rem;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  margin-bottom: 2rem;
`;

const FilterTitle = styled.h3`
  margin-bottom: 1rem;
  color: #2c3e50;
`;

const FilterForm = styled.div`
  display: flex;
  gap: 1rem;
  align-items: end;
  flex-wrap: wrap;
`;

const FilterGroup = styled.div`
  display: flex;
  flex-direction: column;
`;

const Label = styled.label`
  margin-bottom: 0.5rem;
  font-weight: 600;
  color: #2c3e50;
  font-size: 0.9rem;
`;

const Select = styled.select`
  padding: 8px 12px;
  border: 2px solid #e9ecef;
  border-radius: 5px;
  font-size: 14px;
  min-width: 150px;

  &:focus {
    outline: none;
    border-color: #3498db;
  }
`;

const ClearButton = styled.button`
  background-color: #95a5a6;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 14px;
  height: fit-content;

  &:hover {
    background-color: #7f8c8d;
  }
`;

const TaskFilter = ({ onFilterChange }) => {
  const [filters, setFilters] = useState({
    status: '',
    priority: ''
  });

  const handleFilterChange = (filterType, value) => {
    const newFilters = {
      ...filters,
      [filterType]: value
    };
    
    setFilters(newFilters);
    onFilterChange(newFilters);
  };

  const clearFilters = () => {
    const clearedFilters = {
      status: '',
      priority: ''
    };
    
    setFilters(clearedFilters);
    onFilterChange(clearedFilters);
  };

  const hasActiveFilters = filters.status || filters.priority;

  return (
    <FilterContainer>
      <FilterTitle>Filter Tasks</FilterTitle>
      
      <FilterForm>
        <FilterGroup>
          <Label htmlFor="status-filter">Status</Label>
          <Select
            id="status-filter"
            value={filters.status}
            onChange={(e) => handleFilterChange('status', e.target.value)}
          >
            <option value="">All Statuses</option>
            <option value="pending">Pending</option>
            <option value="in-progress">In Progress</option>
            <option value="completed">Completed</option>
          </Select>
        </FilterGroup>

        <FilterGroup>
          <Label htmlFor="priority-filter">Priority</Label>
          <Select
            id="priority-filter"
            value={filters.priority}
            onChange={(e) => handleFilterChange('priority', e.target.value)}
          >
            <option value="">All Priorities</option>
            <option value="low">Low</option>
            <option value="medium">Medium</option>
            <option value="high">High</option>
          </Select>
        </FilterGroup>

        {hasActiveFilters && (
          <ClearButton onClick={clearFilters}>
            Clear Filters
          </ClearButton>
        )}
      </FilterForm>
    </FilterContainer>
  );
};

export default TaskFilter;