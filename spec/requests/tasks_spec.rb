 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/tasks", type: :request do
  
  # Task. As you add validations to Task, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {{
    name: 'Sample Task',
    body: 'Sample Task Body',
    task_date: Date.tomorrow()
  }}

  let(:invalid_attributes) {{
    body: 'Sample Task Body',
    task_date: Date.tomorrow()
  }}

  let!(:category) {Category.create(name: "Sample")}

  describe "GET /index" do
    it "renders a successful response" do
      get category_tasks_path(1)
      expect(response).to be_successful
    end

    it "renders the index template" do
      get category_tasks_path(1)
      expect(response).to render_template(:index)
    end

    it "loads all of the tasks into @tasks" do
      get category_tasks_path(1)
      expect(assigns(:tasks)).to eq(Category.find(1).tasks.all)
    end
  end

  describe "GET /show" do
    before :each do
      category.tasks.create!(valid_attributes)
    end

    it "renders a successful response" do
      get category_task_path(1, 1)
      expect(response).to be_successful
    end

    it "renders the index template" do
      get category_task_path(1, 1)
      expect(response).to render_template(:show)
    end

    it "loads all of the tasks into @tasks" do
      get category_task_path(1, 1)
      expect(assigns(:task)).to eq(Category.find(1).tasks.find(1)) 
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_category_task_path(1)
      expect(response).to be_successful
    end

    it "renders the index template" do
      get new_category_task_path(1)
      expect(response).to render_template(:new)
    end

    # it "load all of the new task instance into @task" do
    #   get new_category_task_path(1)
    #   expect(assigns(:task)).to eq(Category.find(1).tasks.new) <--- different task identifiers/pointers
    # end
  end

  describe "GET /edit" do
    before :each do
      category.tasks.create!(valid_attributes)
    end

    it "renders a successful response" do
      get edit_category_task_path(1, 1)
      expect(response).to be_successful
    end

    it "renders the index template" do
      get edit_category_task_path(1, 1)
      expect(response).to render_template(:edit)
    end

    it "loads all of the tasks into @tasks" do
      get edit_category_task_path(1, 1)
      expect(assigns(:task)).to eq(Category.find(1).tasks.find(1))
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post category_tasks_path(1), params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post category_tasks_path(1), params: { task: valid_attributes }
        expect(response).to redirect_to(category_task_path(1, Category.find(1).tasks.last.id))
        follow_redirect!
        expect(response).to render_template(:show)

      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post category_tasks_path(1), params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post category_tasks_path(1), params: { task: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested task" do
        task = Task.create! valid_attributes
        patch task_url(task), params: { task: new_attributes }
        task.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        patch task_url(task), params: { task: new_attributes }
        task.reload
        expect(response).to redirect_to(task_url(task))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        task = Task.create! valid_attributes
        patch task_url(task), params: { task: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete task_url(task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete task_url(task)
      expect(response).to redirect_to(tasks_url)
    end
  end
end
