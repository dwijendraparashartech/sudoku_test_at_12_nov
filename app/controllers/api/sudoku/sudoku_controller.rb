class Api::Sudoku::SudokuController < ApplicationController
	def sudoku_data
		return render json: SudokuTest.new(params[:data].to_s
			.gsub(/\"/,'\'')
			.gsub(/[\[\]]/, '')
			.gsub(", ","")
			.gsub("nil","0")
			).solve!	
	end
end