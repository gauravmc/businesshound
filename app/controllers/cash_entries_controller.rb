class CashEntriesController < ApplicationController
	before_filter :load_store

	def show
		@cash_entry = @store.cash_entries.find_by_made_on(@made_on)
		redirect_to @cash_entry.present? ? edit_store_cash_entries_url(@store, date: @made_on) : new_store_cash_entries_url(@store, date: @made_on)
	end

	def new
		@cash_entry = @store.cash_entries.build(made_on: @made_on)
	end

	def create
		@made_on = params[:cash_entry][:made_on]
		@cash_entry = @store.cash_entries.build(params[:cash_entry])
		if @cash_entry.save
			flash[:success] = "Cash entry created successfully for #{@cash_entry.made_on.strftime('%B %d, %Y')}"
			redirect_to edit_store_cash_entries_url(@store, date: @cash_entry.made_on)
		else
			flash[:failure] = "Cash entry could not be saved. Please rectify values."
			render 'new'
		end
	end

	def edit
		@cash_entry = @store.cash_entries.find_by_made_on(@made_on)
	end

	def update
		@made_on = params[:cash_entry][:made_on]		
		@cash_entry = @store.cash_entries.find_by_made_on(@made_on)
		if @cash_entry.update_attributes(params[:cash_entry])
			flash[:success] = "Cash entry created updated for #{@cash_entry.made_on.strftime('%B %d, %Y')}"
			redirect_to edit_store_cash_entries_url(@store, date: @cash_entry.made_on)
		else
			flash[:failure] = "Cash entry could not be saved. Please rectify values."
			render 'edit'
		end
	end

	private

	def load_store
    @made_on = date
		@store = Store.find(params[:store_id])
	end
end
