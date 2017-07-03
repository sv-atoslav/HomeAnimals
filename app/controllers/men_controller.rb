class MenController < ApplicationController
  before_action :init_lists,        only: [:new , :edit, :update, ]
  before_action :set_man,           only: [:show, :edit, :update, :destroy]
# before_action :ids_of_my_animals, only: [:show, :edit, :update, :destroy]

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
  end

  # GET /men/1/edit
  def edit
  end

  # POST /men
  # POST /men.json
  def create
    @man = Man.new(man_params)
    respond_to do |format|
      if @man.save
        update_list_my_animals
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
        Animal.all.each do |one_animal|
          if params[:@new_list][one_animal.id] == one_animal.id
            @new_list.push(one_animal.id)
          end
        end
        update_list_my_animals
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
    @new_list = []
    update_list_my_animals
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

  def init_lists
    @old_list = [] #id уже имеющихся животных, пусто на случай нового человека
    @new_list = [] #id выбранных животных
  end

  # def ids_of_my_animals
  #   @old_list = []
  #   ManWithAnimal.where(man: @man.id).each do |pair|
  #     @old_list.push(pair.animal)
  #   end
  #   теперь в @old_list хранятся id "моих" животных
  # end

  def update_list_my_animals
    delete_list = @old_list - @new_list
    delete_list.each do |animal_id|
      ManWithAnimal.find(animal_id).destroy
    end
    create_list = @new_list - @old_list
    create_list.each do |animal_id|
      new_pair = ManWithAnimal.new
      new_pair.animal = animal_id
      new_pair.man = @man.id
      new_pair.save
    end
  end
end
