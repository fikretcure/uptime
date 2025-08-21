<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;

class UptimeCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:uptime-command';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $url = 'https://dentalasistanim.com';

        try {
            $response = Http::timeout(4)->get($url);
            $this->info("Request sent to {$url}. Status: " . $response->status());

            info("Request sent to {$url}. Status: " . $response->status());

        } catch (\Exception $e) {
            $this->error("Request failed: " . $e->getMessage());
            info("Request failed. Status: " . $e->getMessage());
        }
    }
}
