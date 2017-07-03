require 'test_helper'

class ManWithAnimalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @man_with_animal = man_with_animals(:one)
  end

  test "should get index" do
    get man_with_animals_url
    assert_response :success
  end

  test "should get new" do
    get new_man_with_animal_url
    assert_response :success
  end

  test "should create man_with_animal" do
    assert_difference('ManWithAnimal.count') do
      post man_with_animals_url, params: { man_with_animal: { animal: @man_with_animal.animal, man: @man_with_animal.man } }
    end

    assert_redirected_to man_with_animal_url(ManWithAnimal.last)
  end

  test "should show man_with_animal" do
    get man_with_animal_url(@man_with_animal)
    assert_response :success
  end

  test "should get edit" do
    get edit_man_with_animal_url(@man_with_animal)
    assert_response :success
  end

  test "should update man_with_animal" do
    patch man_with_animal_url(@man_with_animal), params: { man_with_animal: { animal: @man_with_animal.animal, man: @man_with_animal.man } }
    assert_redirected_to man_with_animal_url(@man_with_animal)
  end

  test "should destroy man_with_animal" do
    assert_difference('ManWithAnimal.count', -1) do
      delete man_with_animal_url(@man_with_animal)
    end

    assert_redirected_to man_with_animals_url
  end
end
