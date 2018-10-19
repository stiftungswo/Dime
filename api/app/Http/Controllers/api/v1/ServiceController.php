<?php

namespace App\Http\Controllers\Api\V1;

use App\Modules\Service\Models\Service;
use App\Modules\Service\Models\ServiceRate;
use Illuminate\Database\QueryException;
use Illuminate\Http\Response;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;
use Laravel\Lumen\Routing\Controller;

class ServiceController extends Controller
{

    public function index()
    {
        return Service::all();
    }

    public function get($id)
    {
        return Service::find($id);
    }

    public function post()
    {
        $s = Service::create(Input::toArray());

        foreach (Input::get('service_rates') as $rate) {
            $r = ServiceRate::make($rate);
            $r->service_id = $s->id;
            $r->save();
        }
        return $s;
    }

    // i am super unhappy with how complicated this is, but that's the price we pay for doing nested updates.
    // we can probably extract the logic into a generic function though.
    public function put($id)
    {
        try {
            DB::beginTransaction();
            $s = Service::findOrFail($id);
            $s->update(Input::toArray());

            /** @var Collection $currentServiceRates */
            $currentServiceRates = $s->serviceRates->map(function ($r) {
                return $r->id;
            });
            $updatedServiceRates = [];

            foreach (Input::get('service_rates') as $rate) {
                if (!array_has($rate, 'id')) {
                    //insert
                    $r = ServiceRate::make($rate);
                    $r->service_id = $s->id;
                    $r->save();
                } elseif ($currentServiceRates->contains($rate['id'])) {
                    //edit
                    $updatedServiceRates[] = $rate['id'];
                    ServiceRate::findOrFail($rate['id'])->update($rate);
                } else {
                    DB::rollBack();
                    return new Response("Tarif mit der id " . $rate['id'] . " existiert nicht", 400);
                }
            }

            $deletedServiceRates = $currentServiceRates->diff($updatedServiceRates);
            foreach ($deletedServiceRates as $deleted) {
                ServiceRate::destroy($deleted);
            }
        } catch (QueryException $e) {
            if (str_contains($e->getMessage(), 'service_rates_service_id_rate_group_id_unique')) {
                return new Response('Einer der neuen Tarife ist bereits erfasst', 400);
            }
            DB::rollBack();
            throw $e;
        }
        DB::commit();
    }

    public function delete($id)
    {
        Service::findOrFail($id)->delete();
    }
}
