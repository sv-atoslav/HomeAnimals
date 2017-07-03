class ManWithAnimalsController < ApplicationController
  before_action :set_man_with_animal, only: [:show, :edit, :update, :destroy]

  # GET /man_with_animals
  # GET /man_with_animals.json
  def index
    @man_with_animals = ManWithAnimal.all
  end

  # GET /man_with_animals/1
  # GET /man_with_animals/1.json
  def show
  end

  # GET /man_with_animals/new
  def new
    @man_with_animal = ManWithAnimal.new
  end

  # GET /man_with_animals/1/edit
  def edit
  end

  # POST /man_with_animals
  # POST /man_with_animals.json
  def create
    @man_with_animal = ManWithAnimal.new(man_with_animal_params)

    respond_to do |format|
      if @man_with_animal.save
        format.html { redirect_to @man_with_animal, notice: 'Man with animal was successfully created.' }
        format.json { render :show, status: :created, location: @man_with_animal }
      else
        format.html { render :new }
        format.json { render json: @man_with_animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /man_with_animals/1
  # PATCH/PUT /man_with_animals/1.json
  def update
    respond_to do |format|
      if @man_with_animal.update(man_with_animal_params)
        format.html { redirect_to @man_with_animal, notice: 'Man with animal was successfully updated.' }
        format.json { render :show, status: :ok, location: @man_with_animal }
      else
        format.html { render :edit }
        format.json { render json: @man_with_animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /man_with_animals/1
  # DELETE /man_with_animals/1.json
  def destroy
    @man_with_animal.destroy
    respond_to do |format|
      format.html { redirect_to man_with_animals_url, notice: 'Man with animal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_man_with_animal
      @man_with_animal = ManWithAnimal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def man_with_animal_params
      params.require(:man_with_animal).permit(:man, :animal)
    end
end
