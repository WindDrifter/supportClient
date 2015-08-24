class RequestsController < ApplicationController


    before_action :find_request, only: [:show,:edit, :update, :destroy, :status]

    def new
      @request = Request.new
    end

    def create
      @request = Request.new(request_params)
      if @request.save
        redirect_to request_path(@request), notice: "Request Created"
      else
        flash[:alert] = "See errors below"
        render :new
      end

    end

    def status
      if @request.done ==0
        @request.update_attribute(:done, 1) # using boolean is not worth my time debugging (as it cannot change value for odd reasons), I ended up using integer instead
      else
        @request.update_attribute(:done, 0)
      end


      redirect_to requests_path, notice: "Status Changed"
    end

    def show
      #code
    end

    def index
      if params[:search]
      @requests = Request.search(params[:search]).order(:done).page(params[:page]).per(2)
      else
      @requests = Request.all.order(:done).page(params[:page]).per(2)
      end
    end


    def edit

    end

    def update
      if @request.update(request_params)
        redirect_to request_path(@request)
      else
        render :edit
      end
    end
    def destroy
      @request.destroy
      redirect_to requests_path
    end

    private


    def request_params
      if :request
      params.require(:request).permit(:name, :email, :department, :message)
      end
    end



    def find_request
        @request = Request.find(params[:id])
    end
end
