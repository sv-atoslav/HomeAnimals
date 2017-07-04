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
    @man = Man.new(man_params)
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
    @new_list = []
    # if ( action_name != 'destroy')
    #   @new_list = params.require(:@new_list).permit(:id, category_ids: []).to_a
    # end
    if (action_name != 'destroy')
      # n=1
      # params.each do
      #   puts params[n]
      #   if params[n].scan("animal_id_").size==1
      #     @new_list << params[n].value
      #     puts params[n]+" now into c"
      #   end
      #   n+=1
      #   break if n == params.size
      # end
      n = 1
      loop do
        string_param_n = "animal_id_" + n.to_s
        if params[string_param_n.to_s]
          @new_list << params[string_param_n.to_s]
        end
        n += 1
        break if n == Animal.count
      end
    end
    if (action_name == 'create')
      @old_list = []
    end
    puts "new_list is "
    puts @new_list
    puts "old_list is "
    puts @old_list
    if (action_name != 'create')
      delete_list = @old_list - @new_list
      if delete_list.count > 0
        delete_list.each do |animal_id|
          # one_delete_pair =
          ManWithAnimal.where(man: @man.id, animal: :animal_id).destroy
        end
          #puts "one_delete_pair is " + one_delete_pair.to_a.to_s
          #one_delete_pair
      end
    end
    if (action_name != 'destroy')
      create_list = @new_list - @old_list
      create_list.each do |animal_id|
        new_pair = ManWithAnimal.new
        new_pair.animal = animal_id
        new_pair.man = @man.id
        new_pair.save
      end
    end
  end
end
