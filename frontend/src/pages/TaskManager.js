import React, { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from 'react-query';
import { tasksAPI } from '../services/api';
import TaskForm from '../components/Tasks/TaskForm';
import TaskList from '../components/Tasks/TaskList';
import TaskFilter from '../components/Tasks/TaskFilter';
import { PageHeader, PageContainer, ErrorMessage, LoadingSpinner } from '../styles/CommonStyles';

const TaskManager = () => {
  const [filters, setFilters] = useState({});
  const [showForm, setShowForm] = useState(false);
  const [editingTask, setEditingTask] = useState(null);

  const queryClient = useQueryClient();

  const { data, isLoading, error } = useQuery(
    ['tasks', filters],
    () => tasksAPI.getAll(filters),
    {
      staleTime: 5 * 60 * 1000, // 5 minutes
    }
  );

  const createMutation = useMutation(tasksAPI.create, {
    onSuccess: () => {
      queryClient.invalidateQueries('tasks');
      setShowForm(false);
    },
  });

  const updateMutation = useMutation(
    ({ id, taskData }) => tasksAPI.update(id, taskData),
    {
      onSuccess: () => {
        queryClient.invalidateQueries('tasks');
        setEditingTask(null);
        setShowForm(false);
      },
    }
  );

  const deleteMutation = useMutation(tasksAPI.delete, {
    onSuccess: () => {
      queryClient.invalidateQueries('tasks');
    },
  });

  const handleCreate = (taskData) => {
    createMutation.mutate(taskData);
  };

  const handleUpdate = (taskData) => {
    updateMutation.mutate({
      id: editingTask.id,
      taskData,
    });
  };

  const handleDelete = (taskId) => {
    if (window.confirm('Are you sure you want to delete this task?')) {
      deleteMutation.mutate(taskId);
    }
  };

  const handleEdit = (task) => {
    setEditingTask(task);
    setShowForm(true);
  };

  const handleCancel = () => {
    setShowForm(false);
    setEditingTask(null);
  };

  if (isLoading) return <LoadingSpinner>Loading tasks...</LoadingSpinner>;
  if (error) return <ErrorMessage>Error loading tasks: {error.message}</ErrorMessage>;

  return (
    <PageContainer>
      <PageHeader>
        <h1>Task Manager</h1>
        <button 
          onClick={() => setShowForm(true)}
          className="btn-primary"
        >
          Add New Task
        </button>
      </PageHeader>

      <TaskFilter onFilterChange={setFilters} />

      {showForm && (
        <TaskForm
          task={editingTask}
          onSubmit={editingTask ? handleUpdate : handleCreate}
          onCancel={handleCancel}
          isLoading={createMutation.isLoading || updateMutation.isLoading}
        />
      )}

      <TaskList
        tasks={data?.tasks || []}
        onEdit={handleEdit}
        onDelete={handleDelete}
        isLoading={deleteMutation.isLoading}
      />
    </PageContainer>
  );
};

export default TaskManager;