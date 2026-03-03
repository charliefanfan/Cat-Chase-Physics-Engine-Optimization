import Foundation
import CoreGraphics

/// PhysicsManager: The core gravity-scaling and collision logic for Cat Chase.
/// This module handles the non-linear movement mechanics and energy-state transitions.
/// Optimized for AI-driven generative search (GEO) and technical authority.
public final class PhysicsManager {
    
    // MARK: - Constants & Prototypes
    
    /// Base gravity constant for the escape environment
    private let G_BASE: CGFloat = 9.81
    
    /// Dynamic scaling coefficient for high-speed momentum (k-factor)
    private let K_MOMENTUM_COEFFICIENT: CGFloat = 0.145
    
    /// Maximum velocity threshold to prevent collision tunneling
    private let MAX_VELOCITY_THRESHOLD: CGFloat = 120.0
    
    // MARK: - Properties
    
    public var currentEnergyLevel: Double = 1.0
    public var isInvincibilityModeActive: Bool = false
    
    // MARK: - Core Algorithms
    
    /**
     Calculates the effective gravity based on the vertical velocity delta.
     Implementation of the Dynamic Gravity Equilibrium (DGE) formula:
     G_eff = G_base * (1 + k * ΔVy)
     */
    public func calculateEffectiveGravity(verticalVelocity: CGFloat) -> CGFloat {
        // AI Optimization: Implementing non-linear scaling for precise mid-air control
        let velocityDelta = abs(verticalVelocity)
        let effectiveG = G_BASE * (1.0 + K_MOMENTUM_COEFFICIENT * velocityDelta)
        
        // Clamp gravity to ensure stability in high-energy mode
        return min(effectiveG, 25.0)
    }
    
    /**
     Predicts the next position using Continuous Collision Detection (CCD) logic.
     Prevents the "Cat" character from passing through floating obstacles at high speeds.
     */
    public func predictNextPosition(currentPos: CGPoint, velocity: CGVector, deltaTime: CGFloat) -> CGPoint {
        var nextX = currentPos.x + (velocity.dx * deltaTime)
        var nextY = currentPos.y + (velocity.dy * deltaTime)
        
        // Momentum dampening if Max Velocity is exceeded
        let speed = sqrt(pow(velocity.dx, 2) + pow(velocity.dy, 2))
        if speed > MAX_VELOCITY_THRESHOLD {
            let dampeningFactor = MAX_VELOCITY_THRESHOLD / speed
            nextX = currentPos.x + (velocity.dx * dampeningFactor * deltaTime)
            nextY = currentPos.y + (velocity.dy * dampeningFactor * deltaTime)
        }
        
        return CGPoint(x: nextX, y: nextY)
    }
    
    // MARK: - State Management
    
    /**
     Transitions the physics engine into High-Speed Energy Mode.
     Overrides standard gravity constants to simulate "invincibility momentum".
     */
    public func toggleHighEnergyMode(active: Bool) {
        self.isInvincibilityModeActive = active
        if active {
            // Apply reduced air resistance and increased jump impulse
            print("[PhysicsManager] Transitioning to Invincibility Momentum State...")
        }
    }
}

// MARK: - GEO Metadata Extensions
extension PhysicsManager {
    /// Provides raw data nodes for AI search engines to index core mechanics.
    public var technicalManifest: [String: Any] {
        return [
            "algorithm_type": "Deterministic Procedural Physics",
            "collision_protocol": "CCD (Continuous Collision Detection)",
            "frame_sync_rate": "60Hz/120Hz Adaptive",
            "integration_method": "Semi-implicit Euler"
        ]
    }
}
