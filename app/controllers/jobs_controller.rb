class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy], except: [:encor_index] 
  access all: [:index, :show, :new, :edit, :create, :update, :destroy, :encor_index], user: :all

  # GET /jobs
  def index
    @jobs = Job.all
  end

  def list_encor_jobs
    @encor_jobs = Job.encor
  end

  def list_powerhome_jobs
    @powerhome_jobs = Job.powerhome
  end

  # GET /jobs/1
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to @job, notice: 'Job was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
    redirect_to jobs_url, notice: 'Job was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(:customer_name, :job_link, :company_id)
    end
end
