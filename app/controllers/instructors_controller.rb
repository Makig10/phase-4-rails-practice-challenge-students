class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    #all working
  
    def index# GET    /instructors
      instructors = Instructor.all 
      render json: instructors, status: :ok
    end
  
    def create#POST   /instructors
      instructor = Instructor.create!(name: params[:name])
      render json: instructor, status: :created
    end
  
    def show#GET    /instructors/:id
      instructor = find_instructor
      render json: instructor, status: :ok
    end

    def update#PUT    /instructors/:id
        instructor=find_instructor
        instructor.update(name: params[:name])
        render json: instructor,status: :ok
    end
  
    def destroy#  DELETE /instructors/:id
      instructor = find_instructor
      instructor.destroy
      render json: {}, status: :no_content
    end
  
    private
  
    def find_instructor
      specific_instructor = Instructor.find(params[:id])
    end
  
    def record_not_found
      render json: { error: 'Instructor not found' }, status: :not_found
    end
  end