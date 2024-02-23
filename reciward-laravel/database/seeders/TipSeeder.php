<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Tip;

class TipSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Tip::create([
            "nombre_tips" => 'Separación Eficiente de Residuos', 
            "descripcion" => 'Al separar tus residuos, asegúrate de enjuagar los envases antes de desecharlos para evitar la contaminación de otros materiales. Además, infórmate sobre los programas de reciclaje locales para conocer las pautas específicas de clasificación.' , 
            "administrador_id" => 1 
        ]);

        Tip::create([
            "nombre_tips" => 'Reduciendo el Desperdicio de Plástico', 
            "descripcion" => 'Opta por productos a granel siempre que sea posible y lleva contigo tu propia botella de agua reutilizable. Evita los envases de un solo uso y busca alternativas sostenibles, como utensilios de cocina de acero inoxidable en lugar de plástico.' , 
            "administrador_id" => 1 
        ]);

        Tip::create([
            "nombre_tips" => 'Reutilización Creativa en Casa', 
            "descripcion" => 'Antes de desechar algo, piensa en cómo podrías darle una segunda vida. Los tarros de vidrio vacíos pueden convertirse en contenedores para alimentos, y la ropa vieja puede transformarse en trapos reutilizables.' , 
            "administrador_id" => 1 
        ]);

        Tip::create([
            "nombre_tips" => 'Minimizando Residuos de Alimentos', 
            "descripcion" => 'Planifica tus compras de alimentos y utiliza una lista para evitar comprar en exceso. Almacenar adecuadamente los alimentos en el refrigerador también ayuda a prolongar su vida útil. Considera compostar los restos de alimentos para crear abono orgánico.' , 
            "administrador_id" => 1 
        ]);

        Tip::create([
            "nombre_tips" => 'Energía Sostenible en el Hogar', 
            "descripcion" => 'Apaga los electrodomésticos en modo de espera y desconéctalos cuando no estén en uso. Cambiar a bombillas LED no solo reduce el consumo de energía, sino que también disminuye la frecuencia de cambio de bombillas, generando menos residuos.' , 
            "administrador_id" => 1 
        ]);
    }
}
