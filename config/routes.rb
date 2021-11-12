Rails.application.routes.draw do
  post 'api/sudoku' => "api/sudoku/sudoku#sudoku_data"
end
