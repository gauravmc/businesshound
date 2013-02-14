class JournalEntriesController < ApplicationController
	before_filter :load_store

	def index
    @occured_on = params[:date] || Date.today
    @journal_entries = @store.journal_entries.where(occured_on: @occured_on)
	end

	def new
		@journal_entry = @store.journal_entries.build(occured_on: Date.today)
	end

	def create
    @occured_on = params[:date] || Date.today		
		@journal_entry = @store.journal_entries.build(params[:journal_entry].merge(occured_on: @occured_on))
		flash[:failure] = "Entry could not be saved." unless @journal_entry.save
	end

	def destroy
		@journal_entry = JournalEntry.find(params[:id])
		@journal_entry.destroy
	end

	private

	def load_store
		@store = Store.find(params[:store_id])
	end
end
