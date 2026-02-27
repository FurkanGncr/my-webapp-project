<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TODO List</title>
    
    <!-- Bootstrap Icons CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding: 20px;
        }

        /* Main Container */
        .todo-app {
            max-width: 600px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        /* Header */
        .todo-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 30px 25px;
            text-align: center;
        }

        .todo-header h1 {
            font-size: 32px;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .todo-header p {
            font-size: 14px;
            opacity: 0.9;
        }

        /* Input Section */
        .todo-input-section {
            padding: 20px 25px;
            border-bottom: 1px solid #e0e0e0;
            background: #f9f9f9;
        }

        .input-group {
            display: flex;
            gap: 10px;
        }

        .input-group input {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .input-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn-add {
            padding: 12px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
            white-space: nowrap;
        }

        .btn-add:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-add:active {
            transform: translateY(0);
        }

        /* Task List */
        .todo-list {
            list-style: none;
        }

        .task-item {
            display: flex;
            align-items: center;
            padding: 16px 25px;
            border-bottom: 1px solid #e8e8e8;
            transition: background-color 0.2s;
            gap: 12px;
        }

        .task-item:hover {
            background-color: #f5f5f5;
        }

        .task-item.completed .task-text {
            text-decoration: line-through;
            color: #999;
        }

        .task-checkbox {
            flex-shrink: 0;
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: #667eea;
        }

        .task-text {
            flex: 1;
            font-size: 16px;
            color: #333;
            word-break: break-word;
            transition: all 0.2s;
        }

        .task-text.editing {
            display: none;
        }

        .task-input-edit {
            flex: 1;
            display: none;
            padding: 8px 12px;
            border: 2px solid #667eea;
            border-radius: 6px;
            font-size: 16px;
            font-family: inherit;
        }

        .task-input-edit.editing {
            display: block;
        }

        .task-actions {
            display: flex;
            gap: 10px;
            flex-shrink: 0;
        }

        .btn-edit, .btn-delete, .btn-save, .btn-cancel {
            padding: 6px 10px;
            border: none;
            background: none;
            cursor: pointer;
            font-size: 18px;
            transition: all 0.2s;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-edit {
            color: #667eea;
        }

        .btn-edit:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: scale(1.1);
        }

        .btn-delete {
            color: #e74c3c;
        }

        .btn-delete:hover {
            background: rgba(231, 76, 60, 0.1);
            transform: scale(1.1);
        }

        .btn-save {
            color: #27ae60;
            display: none;
        }

        .btn-save.editing {
            display: flex;
        }

        .btn-save:hover {
            background: rgba(39, 174, 96, 0.1);
        }

        .btn-cancel {
            color: #95a5a6;
            display: none;
        }

        .btn-cancel.editing {
            display: flex;
        }

        .btn-cancel:hover {
            background: rgba(149, 165, 166, 0.1);
        }

        /* Empty State */
        .empty-state {
            padding: 60px 25px;
            text-align: center;
            color: #999;
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 15px;
            opacity: 0.5;
        }

        .empty-state-text {
            font-size: 16px;
            margin-bottom: 10px;
        }

        /* Loading State */
        .loading {
            text-align: center;
            padding: 40px 25px;
            color: #999;
        }

        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(102, 126, 234, 0.1);
            border-radius: 50%;
            border-top-color: #667eea;
            animation: spin 0.8s linear infinite;
            margin-right: 10px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 600px) {
            .todo-header h1 {
                font-size: 24px;
            }

            .input-group {
                flex-direction: column;
            }

            .btn-add {
                width: 100%;
                justify-content: center;
            }

            .task-item {
                padding: 14px 15px;
            }

            .task-actions {
                gap: 8px;
            }

            .btn-edit, .btn-delete {
                padding: 5px 8px;
                font-size: 16px;
            }
        }
    </style>
</head>

<body>

    <div class="todo-app">
        <!-- Header -->
        <div class="todo-header">
            <h1><i class="bi bi-check2-square"></i> My Tasks</h1>
            <p>Stay organized and get things done</p>
        </div>

        <!-- Input Section -->
        <div class="todo-input-section">
            <form id="taskForm" class="input-group">
                <input 
                    type="text" 
                    id="taskInput" 
                    placeholder="Add a new task..." 
                    autocomplete="off"
                    required
                >
                <button type="submit" class="btn-add">
                    <i class="bi bi-plus-lg"></i> Add
                </button>
            </form>
        </div>

        <!-- Task List -->
        <div id="taskContainer">
            <ul class="todo-list" id="taskList"></ul>
        </div>
    </div>

    <!-- JavaScript for Task Management -->
    <script>
        const API_BASE = '/my-webapp-project/api/tasks';
        const taskForm = document.getElementById('taskForm');
        const taskInput = document.getElementById('taskInput');
        const taskList = document.getElementById('taskList');
        const taskContainer = document.getElementById('taskContainer');

        // Initialize the app on page load
        document.addEventListener('DOMContentLoaded', () => {
            loadTasks();
        });

        // Load all tasks from backend
        function loadTasks() {
            taskContainer.innerHTML = '<div class="loading"><span class="spinner"></span>Loading tasks...</div>';
            
            fetch(API_BASE)
                .then(response => {
                    if (!response.ok) throw new Error('Failed to load tasks');
                    return response.json();
                })
                .then(tasks => {
                    renderTasks(tasks);
                })
                .catch(error => {
                    console.error('Error loading tasks:', error);
                    taskContainer.innerHTML = '<div class="loading" style="color: #e74c3c;">Error loading tasks. Please refresh the page.</div>';
                });
        }

        // Render tasks in the UI
        function renderTasks(tasks) {
            taskList.innerHTML = '';

            if (tasks.length === 0) {
                taskContainer.innerHTML = `
                    <div class="empty-state">
                        <div class="empty-state-icon"><i class="bi bi-inbox"></i></div>
                        <div class="empty-state-text">No tasks yet!</div>
                        <div style="font-size: 14px; color: #bbb;">Create one to get started</div>
                    </div>
                `;
                return;
            }

            taskContainer.innerHTML = '<ul class="todo-list" id="taskList"></ul>';
            const newTaskList = document.getElementById('taskList');

            tasks.forEach(task => {
                const li = createTaskElement(task);
                newTaskList.appendChild(li);
            });
        }

        // Create a task element
        function createTaskElement(task) {
            const li = document.createElement('li');
            li.className = `task-item ${task.completed ? 'completed' : ''}`;
            li.dataset.id = task.id;

            li.innerHTML = `
                <input type="checkbox" class="task-checkbox" ${task.completed ? 'checked' : ''}>
                <div class="task-text">${escapeHtml(task.title)}</div>
                <input type="text" class="task-input-edit" value="${escapeHtml(task.title)}">
                <div class="task-actions">
                    <button class="btn-edit" title="Edit task" data-action="edit">
                        <i class="bi bi-pencil-square"></i>
                    </button>
                    <button class="btn-save" title="Save task" data-action="save">
                        <i class="bi bi-check-circle-fill"></i>
                    </button>
                    <button class="btn-cancel" title="Cancel" data-action="cancel">
                        <i class="bi bi-x-circle-fill"></i>
                    </button>
                    <button class="btn-delete" title="Delete task" data-action="delete">
                        <i class="bi bi-trash-fill"></i>
                    </button>
                </div>
            `;

            // Event listeners
            const checkbox = li.querySelector('.task-checkbox');
            const editBtn = li.querySelector('[data-action="edit"]');
            const saveBtn = li.querySelector('[data-action="save"]');
            const cancelBtn = li.querySelector('[data-action="cancel"]');
            const deleteBtn = li.querySelector('[data-action="delete"]');
            const taskText = li.querySelector('.task-text');
            const taskInput = li.querySelector('.task-input-edit');

            // Toggle completion
            checkbox.addEventListener('change', () => toggleCompletion(task.id, checkbox.checked));

            // Edit button
            editBtn.addEventListener('click', () => {
                enterEditMode(li, taskText, taskInput, editBtn, saveBtn, cancelBtn);
            });

            // Save button
            saveBtn.addEventListener('click', () => {
                saveTaskEdit(li, task.id, taskInput.value, taskText, taskInput, editBtn, saveBtn, cancelBtn);
            });

            // Cancel button
            cancelBtn.addEventListener('click', () => {
                exitEditMode(li, taskText, taskInput, editBtn, saveBtn, cancelBtn);
                taskInput.value = escapeHtml(task.title);
            });

            // Enter key to save, Escape to cancel
            taskInput.addEventListener('keydown', (e) => {
                if (e.key === 'Enter') {
                    saveTaskEdit(li, task.id, taskInput.value, taskText, taskInput, editBtn, saveBtn, cancelBtn);
                } else if (e.key === 'Escape') {
                    exitEditMode(li, taskText, taskInput, editBtn, saveBtn, cancelBtn);
                    taskInput.value = escapeHtml(task.title);
                }
            });

            // Delete button
            deleteBtn.addEventListener('click', () => deleteTask(task.id, li));

            return li;
        }

        // Enter edit mode
        function enterEditMode(li, taskText, taskInput, editBtn, saveBtn, cancelBtn) {
            taskText.classList.add('editing');
            taskInput.classList.add('editing');
            editBtn.classList.add('editing');
            saveBtn.classList.add('editing');
            cancelBtn.classList.add('editing');
            taskInput.focus();
            taskInput.select();
        }

        // Exit edit mode
        function exitEditMode(li, taskText, taskInput, editBtn, saveBtn, cancelBtn) {
            taskText.classList.remove('editing');
            taskInput.classList.remove('editing');
            editBtn.classList.remove('editing');
            saveBtn.classList.remove('editing');
            cancelBtn.classList.remove('editing');
        }

        // Add new task
        taskForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const title = taskInput.value.trim();

            if (!title) return;

            const newTask = { title: title, completed: false };

            fetch(API_BASE, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(newTask)
            })
            .then(response => {
                if (!response.ok) throw new Error('Failed to create task');
                return response.json();
            })
            .then(createdTask => {
                taskInput.value = '';
                loadTasks();
            })
            .catch(error => {
                console.error('Error creating task:', error);
                alert('Failed to create task. Please try again.');
            });
        });

        // Toggle task completion
        function toggleCompletion(id, isCompleted) {
            const li = document.querySelector(`[data-id="${id}"]`);
            const taskText = li.querySelector('.task-text').textContent;
            
            // Send complete task object with both title and completed
            const updates = { 
                title: taskText, 
                completed: isCompleted 
            };

            fetch(`${API_BASE}/${id}`, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(updates)
            })
            .then(response => {
                if (!response.ok) throw new Error('Failed to update task');
            })
            .catch(error => {
                console.error('Error updating task:', error);
                alert('Failed to update task. Please try again.');
                loadTasks();
            });
        }

        // Save task edit
        function saveTaskEdit(li, id, newTitle, taskText, taskInput, editBtn, saveBtn, cancelBtn) {
            const trimmedTitle = newTitle.trim();

            if (!trimmedTitle) {
                alert('Task title cannot be empty');
                return;
            }

            if (trimmedTitle === taskText.textContent) {
                exitEditMode(li, taskText, taskInput, editBtn, saveBtn, cancelBtn);
                return;
            }

            // Get current completion status from checkbox
            const checkbox = li.querySelector('.task-checkbox');
            const isCompleted = checkbox.checked;

            fetch(`${API_BASE}/${id}`, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ 
                    title: trimmedTitle,
                    completed: isCompleted
                })
            })
            .then(response => {
                if (!response.ok) throw new Error('Failed to update task');
                taskText.textContent = escapeHtml(trimmedTitle);
                taskInput.value = escapeHtml(trimmedTitle);
                exitEditMode(li, taskText, taskInput, editBtn, saveBtn, cancelBtn);
            })
            .catch(error => {
                console.error('Error updating task:', error);
                alert('Failed to update task. Please try again.');
            });
        }

        // Delete task
        function deleteTask(id, li) {
            if (!confirm('Are you sure you want to delete this task?')) return;

            fetch(`${API_BASE}/${id}`, {
                method: 'DELETE'
            })
            .then(response => {
                if (!response.ok) throw new Error('Failed to delete task');
                li.remove();
                if (document.querySelectorAll('.task-item').length === 0) {
                    renderTasks([]);
                }
            })
            .catch(error => {
                console.error('Error deleting task:', error);
                alert('Failed to delete task. Please try again.');
            });
        }

        // Escape HTML to prevent XSS
        function escapeHtml(text) {
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }
    </script>

</body>
</html>