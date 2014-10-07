// ====================================================================
//  Boom.
//  Copyright (c) 2002-2014 by Stefan Hüsges
// ====================================================================

class Boom extends Mutator;

var bool Initialized;

function ModifyPlayer(Pawn Other)
{
    if (NextMutator != None) {
        NextMutator.ModifyPlayer(Other);
    }
}

function PostBeginPlay()
{
    if (Initialized) {
        return;
    }

    Initialized = true;

    Level.Game.RegisterDamageMutator(Self);
}


function MutatorTakeDamage(out int ActualDamage, Pawn Victim, Pawn InstigatedBy, out Vector HitLocation, out Vector Momentum, name DamageType)
{
    if (InstigatedBy.IsA('Bot') || InstigatedBy.IsA('PlayerPawn')) {
        if (Victim.IsA('Bot') || Victim.IsA('PlayerPawn')) {
            Victim.Health = -1;
        }
    }
    if (NextDamageMutator != None) {
        NextDamageMutator.MutatorTakeDamage(ActualDamage, Victim, InstigatedBy, HitLocation, Momentum, DamageType);
    }
}

defaultproperties
{
}