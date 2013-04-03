namespace :unicorn do
	desc "Zero-downtime restart of Unicorn"
	task :restart do
		run "/etc/init.d/unicorn_businesshound restart"
	end

	desc "Start Unicorn"
	task :start do
		run "/etc/init.d/unicorn_businesshound start"
	end

	desc "Stop Unicorn"
	task :stop do
		run "/etc/init.d/unicorn_businesshound stop"
	end
end
