module StateHelper
  def button_state(state, value, button)
    button_to states_upsert_path(state.imdb), method: :post, form_class: "inline", class: "btn #{state.value != value ? "btn-outline " : ""}btn-#{button} mr-2 mt-2", params: { value: value } do
      yield
    end
  end
end
