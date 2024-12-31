"""
Automates the environment setup for the following github repository: 
    - https://github.com/MorphZG/work_schedule_app.git


"""
import os
import subprocess
import sys

def print_message(message):
    """Utility function to print formatted messages."""
    print("\n" + "-" * 40)
    print(message)
    print("-" * 40 + "\n")

def run_command(command, cwd=None):
    """Run a shell command and handle errors."""
    try:
        subprocess.run(command, cwd=cwd, check=True, shell=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")
        sys.exit(1)

def create_env_file(path, content):
    """Create an .env file with the specified content."""
    with open(path, "w") as file:
        file.write(content)

def main():
    print_message("Cloning the repository...")
    run_command("git clone https://github.com/MorphZG/work_schedule_app.git")
    
    project_dir = "work_schedule_app"
    if not os.path.exists(project_dir):
        print("Error: Failed to clone repository.")
        sys.exit(1)
    os.chdir(project_dir)

    # Backend setup
    print_message("Setting up the backend...")
    backend_dir = os.path.join(os.getcwd(), "backend")
    if not os.path.exists(backend_dir):
        print("Error: Backend directory not found.")
        sys.exit(1)
    run_command("npm install", cwd=backend_dir)
    
    print_message("Creating backend .env file...")
    backend_env_content = """PORT=5000
MONGO_URI="mongodb+srv://<username>:<password>@<cluster_url>/db_name"
LOCALHOST="mongodb://127.0.0.1:<port_number>/<db_name>"
"""
    create_env_file(os.path.join(backend_dir, ".env"), backend_env_content)
    print("Backend .env file created. Please replace placeholders with actual values.")

    # Frontend setup
    print_message("Setting up the frontend...")
    frontend_dir = os.path.join(os.getcwd(), "frontend/vite-project")
    if not os.path.exists(frontend_dir):
        print("Error: Frontend directory not found.")
        sys.exit(1)
    run_command("npm install", cwd=frontend_dir)

    print_message("Creating frontend .env file...")
    frontend_env_content = "API_URL=\n"
    create_env_file(os.path.join(frontend_dir, ".env"), frontend_env_content)
    print("Frontend .env file created. Please set the API_URL as needed.")

    # Summary
    print_message("Setup Complete!")
    print("1. To start the backend server: cd backend && npm run dev")
    print("2. To start the frontend server: cd frontend/vite-project && npm run dev")
    print("3. Frontend: http://localhost:4000")
    print("4. Backend: http://localhost:5000")

if __name__ == "__main__":
    main()
