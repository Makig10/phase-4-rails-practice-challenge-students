class StudentsController < ApplicationController
    # When creating or updating a student, they must be associated with an instructor
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
    def index
      students = Student.all 
      render json: students, status: :ok
    end
  
    def create
      instructor = Instructor.find_by(name: params[:instructor_name]) # Find the instructor by name
      if instructor.nil?
        render json: { error: 'Instructor not found' }, status: :not_found
      else
        student = instructor.students.create!(name: params[:name], major: params[:major], age: params[:age])
        render json: student, include: :instructor, status: :created
      end
    end
  
    def show
      student = find_student
      render json: student, status: :ok
    end
  
    def update
      student = find_student
      student.update(name: params[:name])
      render json: student, include: :instructor, status: :ok
    end
  
    def destroy
      student = find_student
      student.destroy
      render json: {}, status: :no_content
    end
  
    private
  
    def find_student
      specific_student = Student.find(params[:id])
    end
  
    def record_not_found
      render json: { error: 'Student not found' }, status: :not_found
    end
  end