class MenController < ApplicationController
  before_action :set_man, only: [ :show, :edit , :update, :destroy]
  before_action :update_list_my_animals, only: [ :update, :destroy, :create]

  # GET /men
  # GET /men.json
  def index
    @men = Man.all
  end

  # GET /men/1
  # GET /men/1.json
  def show
  end

  # GET /men/new
  def new
    @man = Man.new
    @old_list = []
  end

  # GET /men/1/edit
  def edit
  end

  # POST /men
  # POST /men.json
  def create
    respond_to do |format|
      if @man.save
        format.html { redirect_to @man, notice: 'Man was successfully created.' }
        format.json { render :show, status: :created, location: @man }
      else
        format.html { render :new }
        format.json { render json: @man.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /men/1
  # PATCH/PUT /men/1.json
  def update
    respond_to do |format|
      if @man.update(man_params)
        format.html { redirect_to @man, notice: 'Man was successfully updated.' }
        format.json { render :show, status: :ok, location: @man }
      else
        format.html { render :edit }
        format.json { render json: @man.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /men/1
  # DELETE /men/1.json
  def destroy
    @man.destroy
    respond_to do |format|
      format.html { redirect_to men_url, notice: 'Man was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_man
    @man = Man.find(params[:id])
    # ids_of_my_animals
    @old_list = []
    ManWithAnimal.where(man: @man.id).each do |pair|
      @old_list.push(pair.animal)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def man_params
    params.require(:man).permit(:name)
  end

  def update_list_my_animals
    if (action_name == 'destroy')
      ManWithAnimal.where(man: @man.id).each do |one_pair|
        one_pair.destroy
      end
    else
      @new_list = []
      n = 1
      loop do
        string_param_n = "animal_id_" + n.to_s
        if params[string_param_n.to_s]
          @new_list << params[string_param_n.to_s]
        end
        n += 1
        break if n > Animal.count
      end
      if (action_name == 'create')
        @man = Man.new(man_params)
        @man.save
      else
        ManWithAnimal.where(man: @man.id).each do |one_pair|
          if !@new_list.include?(one_pair.animal)
            one_pair.destroy
          end
        end
      end
      @new_list.each do |animal_id|
        if ManWithAnimal.where(man: @man.id, animal: animal_id).count==0
          one_pair = ManWithAnimal.new
          one_pair.animal = animal_id
          one_pair.man = @man.id
          one_pair.save
        end
      end
    end
  end
end
